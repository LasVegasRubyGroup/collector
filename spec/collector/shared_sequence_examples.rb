require 'collector/shared_iterable_examples'

share_examples_for 'all sequences' do
  
  it_should_behave_like 'all iterables that are not iterators'
  
  it 'should have the correct size' do
    subject.size.should == values.size
  end
  
  it 'should equal another sequence with the same contents' do
    subject.should == values
  end
  
  describe 'reverse' do
    it 'should reverse the sequence' do
      subject.reverse.should == values.reverse
    end
    it 'should return the same type' do
      subject.reverse.should be_the_same_type
    end
  end
end

share_examples_for 'all non-empty sequences' do
  
  it_should_behave_like 'all sequences'
  
  describe 'take' do
    it 'should return a sequence of the first n elements' do
      subject.take(2).should == values[0, 2]
    end
    it 'should return the same type' do
      subject.take(2).should be_the_same_type
    end
  end
end
