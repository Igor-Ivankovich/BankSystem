def create_new_account
  db = open_db

  user_identification_number = get_attribute(db, method(:found_identification_number?), TYPE[:check_account])
  currency = get_attribute(db, method(:validation_currency?), TYPE[:currency], user_identification_number)

  do_sql(db, SQL_INSERT[:account], user_identification_number, currency)
end


