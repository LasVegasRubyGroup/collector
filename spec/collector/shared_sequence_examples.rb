require 'collector/shared_iterable_examples'

shared_examples_for 'any sequence' do
  
  it_behaves_like 'any iterable that is not an iterator'
  
  describe '==' do
    context 'given another sequence with the same contents' do
      it 'returns true' do
        subject.should == values
      end
    end
  end
end

shared_examples_for 'a non-empty sequence' do
  it_behaves_like 'any sequence'
  it_behaves_like 'a non-empty iterable'
end
