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
  
  describe 'scan_right' do
    it 'should iterate like scan_left but in reverse' do
      subject.scan_right('') {|_, a| a + _ }.should == ['', 'c', 'cb', 'cba']
    end
  end
  
end
