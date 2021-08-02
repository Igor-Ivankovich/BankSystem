require 'rspec'
require 'stringio'

require_relative '../bank_system'
require_relative "../reports"

describe "report_account_sum" do
  after do
    $stdin = STDIN
  end

  it "Сhecking the correct operation" do
    $stdin  = StringIO.new("\nn\n")
    expect(report_account_sum).to be == nil
  end

  it "Сhecking the correct operation 2" do
    $stdin  = StringIO.new("\nY\n")
    expect(report_account_sum).to be == 0
  end

  it "Сhecking the correct tags" do
    $stdin  = StringIO.new("test\nY\n")
    expect(report_account_sum).to be == 0
  end
end
