require 'collector/shared_iterable_examples'

share_examples_for 'all iterators' do
  
  it_should_behave_like 'all iterables'
  
  describe 'next' do
    it 'should return successive values and rewind at the end' do
      2.times do
        a = []
        loop { a << subject.next }
        a.should == values
      end
    end
  end
  
  describe 'each' do
    context 'with a block' do
      it 'should yield each element to the block' do
        a = []
        subject.each {|_| a << _ }
        a.should == values
      end
    end
    context 'with no block' do
      it 'should return self' do
        subject.each.should equal(subject)
      end
    end
  end
  
  describe 'with_index' do
    
    let :expected do
      b = []
      values.each_with_index {|_, i| b << [_, i] }
      b
    end
    
    context 'with a block' do
      it 'should yield each element with an index to the block' do
        a = []
        subject.with_index {|_, i| a << [_, i] }
        a.should == expected
      end
    end
    context 'with no block' do
      it 'should return an iterator over each element with an index' do
        i = subject.with_index
        a = []
        loop { a << i.next }
        a.should == expected
      end
    end
  end
  
  describe 'with_object' do
    
    let(:expected) { values.each_with_object([]) {|_, o| o << _ } }
    
    context 'with a block' do
      it 'should yield each element with the given object to the block' do
        a = []
        subject.with_object(a) {|_, o| o << _; nil }.should equal(a)
        a.should == expected
      end
    end
    context 'with no block' do
      it 'should return an iterator over each element with the given object' do
        a = []
        i = subject.with_object(a)
        loop do
          _, o = i.next
          o << _
        end
        a.should == expected
      end
    end
  end
  
end
