def exists?
  gets.chomp
  puts 'Yes'
end

#========== Test ===========

RSpec.describe  do
  before do
    io = StringIO.new("Yhes")
    $stdin = io
  end

  after do
    $stdin = STDIN
  end
  describe '#exists?' do
    it 'outputs a confirmation that it exists' do
      a = expect { exists? }
      a.to output("Yges\n").to_stdout
    end
  end
end