require 'rspec'
require 'stringio'

require_relative '../bank_system'

describe "transfer_funds" do
  after do
    $stdin = STDIN
  end

  it "Check work" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 7777,'Test' )
    $stdin  = StringIO.new("7777\nLSL")
    expect(create_new_account).to be == []

    do_sql(open_db, "DELETE FROM account where user_identification_number=7777")
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end
  it "Check identification number" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 7777,'Test' )
    $stdin  = StringIO.new("9999\n7777\nLSL")
    expect(create_new_account).to be == []

    do_sql(open_db, "DELETE FROM account where user_identification_number=7777")
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end
  it "Check currencyr" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 7777,'Test' )
    $stdin  = StringIO.new("7777\n\nLSL")
    expect(create_new_account).to be == []

    do_sql(open_db, "DELETE FROM account where user_identification_number=7777")
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end
end
