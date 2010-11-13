require 'spec_helper'
require 'collector/enumerable/enumerable_spec_helper'

describe Enumerable do
  
  subject { EnumerableSpecHelper::TestEnumerable.new(values) }
  
  let(:values) { [1, 2, 3, 4, 5] }
  
  describe '#drop_right' do
    it 'returns a collection of all but the last n elements' do
      pending 'implement Enumerable#drop_right'
      subject.drop_right(2).should == [1, 2, 3]
    end
  end
  
end
