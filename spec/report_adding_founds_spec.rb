require 'rspec'
require 'stringio'

require_relative '../bank_system'
require_relative "../reports"

describe "report_adding_founds" do
  after do
    $stdin = STDIN
  end

  it "Сhecking the correct operation" do
    $stdin  = StringIO.new("\n\n\n\nn\n")
    expect(report_adding_founds).to be == nil
  end

  it "checking the correct date" do
    $stdin  = StringIO.new("2021-07-29\n\n\n\nn\n")
    expect(report_adding_founds).to be == nil
  end

  it "checking the correct date 2" do
    $stdin  = StringIO.new("2021-07-229\n2021-07-29\n\n\n\nn\n")
    expect(report_adding_founds).to be == nil
  end

  it "checking the correct date 2" do
    $stdin  = StringIO.new("\ntest\n2021-07-29\n\n\nn\n")
    expect(report_adding_founds).to be == nil
  end

  it "Сhecking the correct currency" do
    $stdin  = StringIO.new("\n\nLSL\n\nn\n")
    expect(report_adding_founds).to be == nil
  end

  it "Сhecking the correct currency 2" do
    $stdin  = StringIO.new("\n\ntest\nLSL\n\nn\n")
    expect(report_adding_founds).to be == nil
  end

  it "Checking the filter operation" do
    $stdin  = StringIO.new("\n\n\nHF\nn")
    expect(report_adding_founds).to be == nil
  end
  it "Checking the filter operation" do
    $stdin  = StringIO.new("\n\n\nHF\nY")
    expect(report_adding_founds).to be == 0
  end
end
