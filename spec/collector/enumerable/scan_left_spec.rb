require 'spec_helper'
require 'collector/enumerable/enumerable_spec_helper'

describe Enumerable do
  
  subject { EnumerableSpecHelper::TestEnumerable.new(%w{a b c}) }
  
  describe '#scan_left' do
    it 'iterates like inject but returns all of the accumulator values' do
      subject.scan_left('') {|a, _| a + _ }.should == ['', 'a', 'ab', 'abc']
    end
  end
  
end
