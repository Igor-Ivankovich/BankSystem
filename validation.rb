
def check_identification_number?(number, db)
  db.execute( "select * from users where identification_number = (?)", number ).empty?
end

def found_identification_number?(number, db)
  !db.execute("select * from users where identification_number = (?)", number).empty?
end

def validation_currency?(number, currency, db)
  db.execute("select * from account where user_identification_number = (?) and currency = (?)", [number, currency]).empty?
end

def found_currency?(number, currency, db)
  !db.execute("select * from account where user_identification_number = (?) and currency = (?)", [number, currency]).empty?
end

def validate_start_data
  data = cli_ask("Enter the start date in the format YYYY-MN-DD or YYYY-M-D HH-MM or leave the field blank:", TYPE[:time][:type])
  return unless data
  data += "00:00:00" unless data[/\d{2}:\d{2}:\d{2}/]
end

def validate_end_data
  data = cli_ask("Enter the end date in the format YYYY-MM-DD or YYYY-MM-DD HH-MM or leave the field blank:", TYPE[:time][:type])
  return unless data
  data += "24:00:00" unless data[/\d{2}:\d{2}:\d{2}/]
end