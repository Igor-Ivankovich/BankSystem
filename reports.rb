def report_adding_founds
  db = open_db

  start_data = validate_start_data
  end_data = validate_end_data
  currency = cli_ask(TYPE[:report_currency][:message], TYPE[:report_currency][:type])
  filter = cli_ask(TYPE[:filter][:message], TYPE[:filter][:type])
  output_format = cli_ask(TYPE[:output_format][:message], TYPE[:output_format][:type])

  query = SQL_SELECT[:report_adding_funds]
  query += " and ra.time >= '#{start_data}'" unless start_data.nil?
  query += " and ra.time <= '#{end_data}'" unless end_data.nil?
  query += " and currency = '#{currency}'" unless currency.nil?
  query += " and name LIKE '%#{filter}%'" unless filter.nil?

  output =  db.execute(query)
  output_format  ? creat_output_csv_file(output, %w[currency time sum name]) :
    to_table(output.unshift(%w[currency time sum name]))
end

##############################################################

def report_transfer_founds
  db = open_db

  start_data = validate_start_data
  end_data = validate_end_data
  tags = cli_ask(TYPE[:filter][:message], TYPE[:filter][:type])
  output_format = cli_ask(TYPE[:output_format][:message], TYPE[:output_format][:type])

  query = SQL_SELECT[:report_transfer_sum]
  query += " and r.time >= '#{start_data}'" unless start_data.nil?
  query += " and r.time <= '#{end_data}'" unless end_data.nil?
  tags.split(';').reject { |val| val.empty? }.each { |tag| query += " and tags LIKE '%#{tag}%'" } unless tags.nil?
  query += " group by u.tags"

  output =  db.execute(query)
  output_format  ? creat_output_csv_file(output, %w[currency time max min avg tag]) :
    to_table(output.unshift(%w[currency time max min avg tag]))
end

##############################################################

def report_account_sum
  db = open_db

  tags = cli_ask(TYPE[:filter][:message], TYPE[:filter][:type])
  output_format = cli_ask(TYPE[:output_format][:message], TYPE[:output_format][:type])

  query = SQL_SELECT[:report_acc_sum]
  tags.split(';').reject { |val| val.empty? }.each { |tag| query += " and u.tags LIKE '%#{tag}%'" } unless tags.nil?
  query += " group by a.currency"
  query += " ,u.tags" unless tags.nil?

  output =  db.execute(query)
  output_format  ? creat_output_csv_file(output, %w[currency sum count]) :
    to_table(output.unshift(%w[currency sum count]))
end

##############################################################

def create_output_table(output, hat)
  puts hat
  output.each { |val|  puts val.to_s.gsub(',', ' |').gsub(/\]|\[/, '')
  }
end

def creat_output_csv_file(output, hat)
  CSV.open("report.csv", "w") do |csv|
    csv << hat
    output.each { |val| csv << val }
  end
  0
end


def to_table(data)
  lengths_array = []
  column_sizes = data.map do |row|
    row.each_with_index.map{|iterand, index| lengths_array[index] = [lengths_array[index] || 0, iterand.to_s.length].max}
  end.max

  head = '+' + column_sizes.map { |column_size| '-' * (column_size + 2) }.join('+') + '+'
  puts head

  to_print = data.clone
  header = to_print.shift
  print_table_data_row(column_sizes, header)
  puts head
  to_print.each { |row| print_table_data_row(column_sizes, row) }
  puts head
end

def print_table_data_row(column_sizes, row)
  row = row.fill(nil, row.size..(column_sizes.size - 1))
  row = row.each_with_index.map { |v, i| v = v.to_s + ' ' * (column_sizes[i] - v.to_s.length) }
  puts '| ' + row.join(' | ') + ' |'
end