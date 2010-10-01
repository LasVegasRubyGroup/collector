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
  
  describe 'each_with_object' do
    
    context 'with a block given' do
      it 'should iterate the block for each element with an object and return the object' do
        subject.each_with_object([]) {|_, a| a << _ }.should == %w{a b c}
      end
    end
    
    context 'with no block given' do
      it 'should return an enumerator' do
        o = []
        e = subject.each_with_object(o)
        loop do
          _, a = e.next
          a << _
        end
        o.should == %w{a b c}
      end
    end
    
  end
  
end
