require 'spec_helper'
require 'collector/enumerable/enumerable_spec_helper'

describe 'Enumerable' do
  
  subject { EnumerableSpecHelper::TestEnumerable.new(%w{a b c}) }
  
  describe '#flat_map' do
    it 'maps, then concatenates the results' do
      pending 'implement Enumerable#flat_map'
      subject.flat_map {|s| (1..3).map {|i| "#{s}#{i}" } }.to_a.should ==
        %w{a1 a2 a3 b1 b2 b3 c1 c2 c3}
    end
  end
  
  describe '#collect_concat' do
    it 'maps, then concatenates the results' do
      pending 'implement Enumerable#collect_concat'
      subject.collect_concat {|s| (1..3).collect {|i| "#{s}#{i}" } }.to_a.should ==
        %w{a1 a2 a3 b1 b2 b3 c1 c2 c3}
    end
  end
  
end
