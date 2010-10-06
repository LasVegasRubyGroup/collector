require 'collector/generic/iterator'

share_examples_for 'all iterables' do
  
  describe 'each' do
    context 'with a block' do
      it 'should yield each element to the block' do
        a = []
        subject.each {|_| a << _ }
        a.should == values
      end
    end
    context 'with no block' do
      it 'should return an external iterator' do
        a = []
        i = subject.each
        loop { a << i.next }
        a.should == values
      end
    end
  end
  
  describe 'map' do
    context 'with a block' do
      it 'should apply the block to each element' do
        subject.map {|_| _.to_s * 2 }.should == values.map {|_| _.to_s * 2 }
      end
    end
    context 'with no block' do
      it 'should return a mapping iterator' do
        subject.map.with_index {|_, i| "#{_}#{i}"}.should ==
          values.each_with_index.map {|_, i| "#{_}#{i}"}
      end
    end
  end
  
  describe 'select' do
    context 'with no block' do
      it 'should return an external iterator' do
        subject.select.should respond_to(:next)
      end
    end
  end
  
  describe 'reject' do
    context 'with no block' do
      it 'should return an external iterator' do
        subject.reject.should respond_to(:next)
      end
    end
  end
  
  describe 'zip' do
    context 'with a block' do
      it 'should yield corresponding elements to the block' do
        a = []
        subject.zip(values.reverse) {|_| a << _ }
        a.should == values.zip(values.reverse)
      end
    end
    context 'with no block' do
      it 'should return a collection of arrays of corresponding elements' do
        subject.zip(values.reverse).to_a.should == values.zip(values.reverse)
      end
    end
  end
  
  def be_the_same_type
    simple_matcher('be the same type') do |given, matcher|
      matcher.failure_message =
        "expected #{given.inspect} to be the same type as #{subject.inspect}"
      given.is_a?(subject.class) or subject.is_a?(given.class)
    end
  end
  
end

share_examples_for 'all non-empty iterables' do
  
  it_should_behave_like 'all iterables'
  
  describe 'take' do
    it 'should return a sequence of the first n elements' do
      subject.take(2).should == values.take(2)
    end
  end
  
  describe 'zip' do
    it 'should pad shorter sequences with nil' do
      subject.zip(values[0..-2]).to_a.last.should == [values.last, nil]
    end
  end
  
end

share_examples_for 'all iterables that are not iterators' do
  
  it_should_behave_like 'all iterables'
  
  describe 'map' do
    context 'with a block' do
      it 'should return the same type of collection' do
        subject.map {|_| _.to_s * 2 }.should be_the_same_type
      end
    end
  end
  
  describe 'select' do
    context 'with a block' do
      it 'should return the same type of collection' do
        subject.select { true }.should be_the_same_type
      end
    end
  end
  
  describe 'reject' do
    context 'with a block' do
      it 'should return the same type of collection' do
        subject.reject { false }.should be_the_same_type
      end
    end
  end
  
  describe 'take' do
    it 'should return the same type' do
      subject.take(1).should be_the_same_type
    end
  end
  
  describe 'zip' do
    context 'with no block' do
      it 'should return the same type of collection' do
        subject.zip(values.reverse).should be_the_same_type
      end
    end
  end
  
end
