require "sqlite3"

db = SQLite3::Database.new "test.db"

db.execute 'CREATE TABLE IF NOT EXISTS
    "users"
     (
      name varchar(30),
      surname varchar(30),
      patronymic varchar(30),
      identification_number int primary key,
      tags varchar(30)
      )'

db.execute 'CREATE TABLE IF NOT EXISTS
    "account"
     (
      account_number integer primary key autoincrement,
      user_identification_number int,
      currency varchar(30),
      sum float,
      foreign key (user_identification_number) references user (identification_number)
      )'

db.execute 'CREATE TABLE IF NOT EXISTS
    "report_adding_found"
     (
      time datetime,
      sum float,
      currency varchar(30),
      user_identification_number int,
      foreign key (user_identification_number) references user (identification_number)
      )'

db.execute 'CREATE TABLE IF NOT EXISTS
    "report_transfer_found"
     (
      time datetime,
      sum float,
      currency varchar(30),
      user_identification_number int,
      foreign key (user_identification_number) references user (identification_number)
      )'