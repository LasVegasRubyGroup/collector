require 'spec_helper'
require 'collector/enumerable/enumerable_spec_helper'

describe Enumerable do
  
  subject { EnumerableSpecHelper::TestEnumerable.new(values) }
  
  let(:values) { [1, 2, 3, 4, 5] }
  
  describe '#take_right' do
    it 'returns a collection of the last n elements' do
      pending 'implement Enumerable#take_right'
      subject.take_right(2).should == [3, 4, 5]
    end
  end
  
end
