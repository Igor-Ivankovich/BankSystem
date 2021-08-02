require 'rspec'
require 'stringio'

require_relative '../bank_system'

describe "transfer_funds" do
  after do
    $stdin = STDIN
  end
  it "Check work" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 9999,'Test' )
    do_sql(open_db, SQL_INSERT[:account], 9999, 'LSL')

    $stdin  = StringIO.new("9999\nLSL\n30")
    adding_funds
    expect(do_sql(open_db, 'SELECT sum FROM account WHERE user_identification_number=9999 and currency=\'LSL\'')[0][0]).to be == 30

    do_sql(open_db, "DELETE FROM account where user_identification_number=9999 and currency=\'LSL\'")
    do_sql(open_db, "DELETE FROM users where identification_number = 9999")
  end
  it "Check work 2" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 9999,'Test' )
    do_sql(open_db, SQL_INSERT[:account], 9999, 'LSL')

    $stdin  = StringIO.new("9999\nLSL\n-30\n30")
    adding_funds
    expect(do_sql(open_db, 'SELECT sum FROM account WHERE user_identification_number=9999 and currency=\'LSL\'')[0][0]).to be == 30

    do_sql(open_db, "DELETE FROM account where user_identification_number=9999 and currency=\'LSL\'")
    do_sql(open_db, "DELETE FROM users where identification_number = 9999")
  end
  it "Check work 3" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 9999,'Test' )
    do_sql(open_db, SQL_INSERT[:account], 9999, 'LSL')

    $stdin  = StringIO.new("9999\nLSL\ntest\n30")
    adding_funds
    expect(do_sql(open_db, 'SELECT sum FROM account WHERE user_identification_number=9999 and currency=\'LSL\'')[0][0]).to be == 30

    do_sql(open_db, "DELETE FROM account where user_identification_number=9999 and currency=\'LSL\'")
    do_sql(open_db, "DELETE FROM users where identification_number = 9999")
  end
end
