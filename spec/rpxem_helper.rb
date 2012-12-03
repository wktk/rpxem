require 'rpxem'
require 'rspec'
require 'stringio'

def capture
  begin
    $stdout = result = StringIO.new
    yield
  ensure
    $stdout = STDOUT
  end
  result.string
end
