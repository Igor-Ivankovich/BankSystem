require 'date'

def adding_funds
  db = open_db

  user_identification_number = get_attribute(db, method(:found_identification_number?), TYPE[:check_account])
  currency = get_attribute(db, method(:found_currency?), TYPE[:currency], user_identification_number, method(:create_new_account))
  sum = cli_ask(TYPE.dig(:sum, :message), TYPE.dig(:sum,:type)).to_f
  current_sum = do_sql(db, SQL_SELECT[:current_sum], user_identification_number, currency)
  new_sum = sum + current_sum[0][0]

  do_sql(db, SQL_INSERT[:sum], new_sum, user_identification_number, currency)
  do_sql(db, SQL_INSERT[:report_sum], DateTime.now.to_s, sum, currency, user_identification_number, )

end

