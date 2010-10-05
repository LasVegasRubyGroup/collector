require "spec_helper"

describe Enumerable do
  
  subject do
    o = Object.new
    class << o
      include Enumerable
      def each
        yield 'a'
        yield 'b'
        yield 'c'
      end
    end
    o
  end
  
  describe 'scan_left' do
    it 'should iterate like inject but return all of the accumulator values' do
      subject.scan_left('') {|a, _| a + _ }.should == ['', 'a', 'ab', 'abc']
    end
  end
  
end
