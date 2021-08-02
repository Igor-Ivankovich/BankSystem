def transfer_funds
  db = open_db

  originator_identification_number = get_attribute(db, method(:found_identification_number?),
                                                   TYPE[:check_account_originator])
  recipient_identification_number = get_attribute(db, method(:found_identification_number?),
                                                  TYPE[:check_account_recipient])
  currency = get_attribute(db, method(:found_currency?), TYPE[:currency],
                           recipient_identification_number, method(:create_new_account))

  originator_current_sum = do_sql(db, SQL_SELECT[:current_sum], originator_identification_number, currency)
  return puts MESSAGES[:no_found_currency] if originator_current_sum.empty?

  recipient_current_sum = do_sql(db, SQL_SELECT[:current_sum], recipient_identification_number, currency)
  sum = 0

  loop do
    sum = cli_ask(TYPE.dig(:sum, :message), TYPE.dig(:sum, :type)).to_i
    break if originator_current_sum[0][0] - sum >= 0
    puts MESSAGES[:not_enough_funds]
  end

  originator_current_sum[0][0] -= sum
  recipient_current_sum[0][0] += sum

  do_sql(db, SQL_INSERT[:sum], originator_current_sum[0][0], originator_identification_number, currency)
  do_sql(db, SQL_INSERT[:sum], recipient_current_sum[0][0], recipient_identification_number, currency)
  do_sql(db, SQL_INSERT[:report_transfer_sum], DateTime.now.to_s, sum, currency, originator_identification_number )
end
