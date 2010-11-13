require 'spec_helper'
require 'collector/enumerable/enumerable_spec_helper'

describe Enumerable do
  
  subject { EnumerableSpecHelper::TestEnumerable.new(%w{a b c}) }
  
  describe '#each_with_object' do
    
    context 'with a block given' do
      it 'iterates the block for each element with an object and returns the object' do
        subject.each_with_object([]) {|_, a| a << _ }.should == %w{a b c}
      end
    end
    
    context 'with no block given' do
      it 'returns an enumerator' do
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
