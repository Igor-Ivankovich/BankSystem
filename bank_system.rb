require "sqlite3"
require "tty-prompt"
require 'csv'

require_relative 'create_user'
require_relative 'opening_account'
require_relative 'adding_funds'
require_relative 'transfer_funds'
require_relative 'cli_ask'
require_relative 'validation'
require_relative 'bank_constant'
require_relative 'reports'


def main
  prompt = TTY::Prompt.new

  loop do
    puts MESSAGES[:help]
    cmd, promt = prompt.ask(MESSAGES[:actions])

    case cmd
    when "create_new_user"
      create_new_user
    when "create_new_account"
      create_new_account
    when "adding_funds"
      adding_funds
    when "transfer_funds"
      transfer_funds
    when "report_adding_founds"
      report_adding_founds
    when "report_transfer_founds"
      report_transfer_founds
    when "report_account_sum"
      report_account_sum
    when "help"
      puts MESSAGES[:functional]
    when "exit"
      break if prompt.yes?(MESSAGES[:exit])
    end
  end
end

def open_db
  SQLite3::Database.open "test.db"
end

def do_sql(db, sql_query, *args)
  db.execute(sql_query, args)
end

def get_attribute(db, validation_function, type, number=nil, function=nil)
  loop do
    attribute = cli_ask(type[:message], type[:type])
    if number
      break attribute if validation_function.call(number, attribute, db)
    else
      break attribute if validation_function.call(attribute, db)
    end
    puts "#{attribute} #{type[:error_message]}"
    function.call if function
  end
end

if __FILE__ == $0
  main
end
