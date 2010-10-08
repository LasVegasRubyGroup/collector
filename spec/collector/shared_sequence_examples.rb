require 'collector/shared_iterable_examples'

share_examples_for 'all sequences' do
  
  it_should_behave_like 'all iterables that are not iterators'
  
  it 'should equal another sequence with the same contents' do
    subject.should == values
  end
  
end

share_examples_for 'all non-empty sequences' do
  
  it_should_behave_like 'all sequences'
  it_should_behave_like 'all non-empty iterables'
  
end
