require 'rspec'
require 'stringio'
require_relative '../transfer_funds'
require_relative '../bank_system'

describe "transfer_funds" do
  after do
    $stdin = STDIN
  end

  it "Check work" do
    $stdin  = StringIO.new("Test\nTest\nTest\nTest\n7777")
    expect(create_new_user).to be == []
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end
  it "Check Name" do

    $stdin  = StringIO.new("\nTest\nTest\nTest\nTest\n7777")
    expect(create_new_user).to be == []
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end
  it "Check identification number" do
    do_sql(open_db, SQL_INSERT[:users], 'Test', 'Test', 'Test', 9999,'Test' )
    $stdin  = StringIO.new("Test\nTest\nTest\nTest\n9999\n7777")
    expect(create_new_user).to be == []
    do_sql(open_db, "DELETE FROM users where identification_number = 9999")
    do_sql(open_db, "DELETE FROM users where identification_number = 7777")
  end
end
