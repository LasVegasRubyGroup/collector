require 'collector/generic/iterator'

shared_examples_for 'any iterable' do
  
  describe '#each' do
    context 'with a block given' do
      it 'yields each element to the block' do
        a = []
        subject.each {|_| a << _ }
        a.should == values
      end
    end
    context 'with no block given' do
      it 'returns an external iterator' do
        a = []
        i = subject.each
        loop { a << i.next }
        a.should == values
      end
    end
  end
  
  describe '#count' do
    it 'returns the number of elements in the collection' do
      subject.count.should == values.count
    end
  end
  
  describe '#map' do
    context 'with a block given' do
      it 'applies the block to each element' do
        subject.map {|_| _.to_s * 2 }.to_a.
        should == values.map {|_| _.to_s * 2 }
      end
    end
    context 'with no block given' do
      it 'returns a mapping iterator' do
        subject.map.with_index {|_, i| "#{_}#{i}"}.should ==
          values.each_with_index.map {|_, i| "#{_}#{i}"}
      end
    end
  end
  
  describe '#select' do
    context 'with no block given' do
      it 'returns an external iterator' do
        subject.select.should respond_to(:next)
      end
    end
  end
  
  describe '#reject' do
    context 'with no block given' do
      it 'returns an external iterator' do
        subject.reject.should respond_to(:next)
      end
    end
  end
  
  describe '#zip' do
    context 'with a block given' do
      it 'yields corresponding elements to the block' do
        a = []
        subject.zip(values.reverse) {|_| a << _ }
        a.should == values.zip(values.reverse)
      end
    end
    context 'with no block given' do
      it 'returns a collection of arrays of corresponding elements' do
        subject.zip(values.reverse).to_a.should == values.zip(values.reverse)
      end
    end
  end
  
end

shared_examples_for 'a non-empty iterable' do
  
  it_behaves_like 'any iterable'
  
  describe '#take' do
    it 'returns a collection of the first n elements' do
      subject.take(2).to_a.should == values.take(2)
    end
  end
  
  describe '#drop' do
    it 'should return a collection of all but the first n elements' do
      subject.drop(1).to_a.should == values.drop(1)
      subject.drop(2).to_a.should == values.drop(2)
    end
  end
  
  describe '#take_right' do
    it 'returns a collection of the last n elements' do
      pending 'implement Iterable#take_right'
      subject.take_right(2).to_a.should == values.drop(values.size - 2)
    end
  end
  
  describe '#drop_right' do
    it 'returns a collection of all but the last n elements' do
      pending 'implement Iterable#drop_right'
      subject.drop_right(1).to_a.should == values.take(values.size - 1)
      subject.drop_right(2).to_a.should == values.take(values.size - 2)
    end
  end
  
  describe '#zip' do
    it 'pads shorter collections with nil' do
      subject.zip(values[0..-2]).to_a.last.should == [values.last, nil]
    end
  end
  
  describe '#reverse' do
    it 'returns a new collection with the same elements in reverse order' do
      subject.reverse.should == values.reverse
    end
  end
  
end

shared_examples_for 'any iterable that is not an iterator' do
  
  it_behaves_like 'any iterable'
  
  describe '#map' do
    context 'with a block given' do
      it 'returns the same type of collection' do
        subject.map {|_| _.to_s * 2 }.should be_the_same_type
      end
    end
  end
  
  describe '#select' do
    context 'with a block given' do
      it 'returns the same type of collection' do
        subject.select { true }.should be_the_same_type
      end
    end
  end
  
  describe '#reject' do
    context 'with a block given' do
      it 'returns the same type of collection' do
        subject.reject { false }.should be_the_same_type
      end
    end
  end
  
  describe '#take' do
    it 'returns the same type of collection' do
      subject.take(1).should be_the_same_type
    end
  end
  
  describe '#drop' do
    it 'returns the same type of collection' do
      pending 'Implement Iterable#drop'
      subject.drop(1).should be_the_same_type
    end
  end
  
  describe '#take_while' do
    it 'returns the same type of collection' do
      pending 'Implement Iterable#take_while'
      subject.take_while { true }.should be_the_same_type
    end
  end
  
  describe '#drop_while' do
    it 'returns the same type of collection' do
      pending 'Implement Iterable#drop_while'
      subject.drop_while { false }.should be_the_same_type
    end
  end
  
  describe '#take_right' do
    it 'returns the same type of collection' do
      pending 'Implement Iterable#take_right'
      subject.take_right(1).should be_the_same_type
    end
  end
  
  describe '#drop_right' do
    it 'returns the same type of collection' do
      pending 'Implement Iterable#drop_right'
      subject.drop_right(1).should be_the_same_type
    end
  end
  
  describe '#zip' do
    context 'with no block' do
      it 'returns the same type of collection' do
        subject.zip(values.reverse).should be_the_same_type
      end
    end
  end
  
  describe '#reverse' do
    it 'returns the same type of collection' do
      subject.reverse.should be_the_same_type
    end
  end
  
  RSpec::Matchers.define :be_the_same_type do
    match do |collection|
      collection.is_a?(subject.class) or subject.is_a?(collection.class)
    end
    description do
      'be the same type of collection'
    end
    failure_message_for_should do |collection|
      "expected #{collection.inspect} to be the same type of collection as #{subject.inspect}"
    end
  end
  
end
