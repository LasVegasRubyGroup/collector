require 'spec_helper'
require 'collector/enumerable/enumerable_spec_helper'

describe Enumerable do
  
  subject { EnumerableSpecHelper::TestEnumerable.new(%w{a b c}) }
  
  describe '#scan_right' do
    it 'iterates like scan_left but in reverse' do
      subject.scan_right('') {|_, a| a + _ }.should == ['', 'c', 'cb', 'cba']
    end
  end
  
end
