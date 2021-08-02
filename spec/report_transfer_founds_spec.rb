require 'rspec'
require 'stringio'

require_relative '../bank_system'
require_relative "../reports"

describe "report_transfer_founds" do
  after do
    $stdin = STDIN
  end

  it "Сhecking the correct operation" do
    $stdin  = StringIO.new("\n\n\nn\n")
    expect(report_transfer_founds).to be == nil
  end

  it "Сhecking the correct operation 2" do
    $stdin  = StringIO.new("\n\n\nY\n")
    expect(report_transfer_founds).to be == 0
  end

  it "Checking the correct date" do
    $stdin  = StringIO.new("\n2021-07-29\n\nn\n")
    expect(report_transfer_founds).to be == nil
  end

  it "Checking the correct date 2" do
    $stdin  = StringIO.new("dsfsdf\n2021-07-29\n\n\nn\n")
    expect(report_transfer_founds).to be == nil
  end

  it "Сhecking the correct filter" do
    $stdin  = StringIO.new("\n\ndifj\nn\n")
    expect(report_transfer_founds).to be == nil
  end
end
