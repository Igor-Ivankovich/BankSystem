def create_new_user
  db = open_db

  name = cli_ask(TYPE.dig(:text, :message_name), TYPE.dig(:text,:type))
  surname = cli_ask(TYPE.dig(:text, :message_surname), TYPE.dig(:text,:type))
  patronymic = cli_ask(TYPE.dig(:text, :message_patronymic), TYPE.dig(:text,:type))
  tags = cli_ask(TYPE.dig(:tag, :message), TYPE.dig(:tag,:type))
  tags = ";#{tags};" if tags
  identification_number = get_attribute(db, method(:check_identification_number?), TYPE[:identification_number])

  do_sql(db, SQL_INSERT[:users], name, surname, patronymic, identification_number, tags)
end
