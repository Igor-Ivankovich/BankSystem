require 'rspec'
require 'stringio'
require_relative '../transfer_funds'
require_relative '../bank_system'


describe "transfer_funds" do
  after do
    $stdin = STDIN
  end

  it "Checking when the transfer amount exceeds the sender's amount" do
    $stdin  = StringIO.new("123\n321\nLSL\n3000\n30")
    expect(transfer_funds).to be == []
  end

  it "Checking that the sender does not have an account with this currency" do
    $stdin  = StringIO.new("123\n321\nUGX")
    expect(transfer_funds).to be == nil
  end

  it "Checking transfer" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 9999,'Test' )
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 7777,'Test' )


    do_sql(open_db, SQL_INSERT[:account], 9999, 'LSL')
    do_sql(open_db, SQL_INSERT[:account], 7777, 'LSL')
    do_sql(open_db, SQL_INSERT[:sum], 100, 9999, 'LSL')
    $stdin  = StringIO.new("9999\n7777\nLSL\n10")
    transfer_funds
    expect(do_sql(open_db, 'SELECT sum FROM account WHERE user_identification_number=9999 and currency=\'LSL\'')[0][0]).to be == 90
    do_sql(open_db, "DELETE FROM account where user_identification_number=9999")
    do_sql(open_db, "DELETE FROM account where user_identification_number=7777")
    do_sql(open_db, "DELETE FROM users where identification_number = 9999")
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end

  it "Checking transfer 2 " do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 9999,'Test' )
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 7777,'Test' )


    do_sql(open_db, SQL_INSERT[:account], 9999, 'LSL')
    do_sql(open_db, SQL_INSERT[:account], 7777, 'LSL')
    do_sql(open_db, SQL_INSERT[:sum], 100, 9999, 'LSL')
    $stdin  = StringIO.new("9999\n7777\nLSL\n10")
    transfer_funds
    expect(do_sql(open_db, 'SELECT sum FROM account WHERE user_identification_number=7777 and currency=\'LSL\'')[0][0]).to be == 10
    do_sql(open_db, "DELETE FROM account where user_identification_number=9999")
    do_sql(open_db, "DELETE FROM account where user_identification_number=7777")
    do_sql(open_db, "DELETE FROM users where identification_number = 9999")
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end

end

describe "get_attribute" do
  after do
    $stdin = STDIN
  end
  it "Checking the existence of the sender user" do
    $stdin  = StringIO.new("123")
    expect(get_attribute(open_db, method(:found_identification_number?),
                         TYPE[:check_account_originator])).to be == '123'
  end
  it "Checking the existence of the sender user 2" do
    $stdin  = StringIO.new("124453453\n123")
    expect(get_attribute(open_db, method(:found_identification_number?),
                  TYPE[:check_account_originator])).to be == '123'
  end
  it "Checking the validity of the entered data sender" do
    $stdin  = StringIO.new("test\n123")
    expect(get_attribute(open_db, method(:found_identification_number?),
                         TYPE[:check_account_originator])).to be == '123'
  end
  it "Checking the existence of the recipient user" do
    $stdin  = StringIO.new("123")
    expect(get_attribute(open_db, method(:found_identification_number?),
                         TYPE[:check_account_recipient])).to be == '123'
  end
  it "Checking the existence of the recipient user 2" do
    $stdin  = StringIO.new("124453453\n123")
    expect(get_attribute(open_db, method(:found_identification_number?),
                         TYPE[:check_account_recipient])).to be == '123'
  end
  it "Checking the validity of the entered data recipient 2" do
    $stdin  = StringIO.new("test\n123")
    expect(get_attribute(open_db, method(:found_identification_number?),
                         TYPE[:check_account_recipient])).to be == '123'
  end

  it "Checking the correct currency entry" do
    $stdin  = StringIO.new("LSL")
    expect(get_attribute(open_db, method(:found_currency?), TYPE[:currency],
                         123, method(:create_new_account))).to be == "LSL"
  end
  it "Checking the correct currency entry" do
    $stdin  = StringIO.new("bfg\nLSL")
    expect(get_attribute(open_db, method(:found_currency?), TYPE[:currency],
                         123, method(:create_new_account))).to be == "LSL"
  end
end