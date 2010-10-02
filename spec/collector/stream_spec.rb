require 'collector/stream'
require 'collector/shared_sequence_examples'
require 'collector/shared_iterator_examples'

describe Stream do
  
  context 'when constructed empty' do
    
    subject { Stream[] }
    
    let(:values) { [] }
    
    it_should_behave_like 'all sequences'
    
    it "should say it's empty" do
      subject.should be_empty
    end
  end
  
  context 'when constructed with items' do
    
    subject { Stream[1, 2, 3] }
    
    let(:values) { [1, 2, 3] }
    
    it_should_behave_like 'all non-empty sequences'
    
    it 'should equal another stream of the same items' do
      subject.should == Stream[1, 2, 3]
    end
    
    describe 'head' do
      it 'should return the first item' do
        subject.head.should == 1
      end
    end
    
    describe 'tail' do
      it 'should return a Stream of all but the first item' do
        subject.tail.should eql Stream[2, 3]
      end
    end
    
    describe 'select' do
      
      subject { Stream[4, 1, 5, 6, 2, 7, 3, 8] }
      
      context 'with a block' do
        it 'should return all the elements that fit the predicate' do
          subject.select {|_| _ < 4 }.should eql Stream[1, 2, 3]
        end
      end
      context 'with no block' do
        it 'should return a selecting iterator' do
          subject.select.with_index {|_, i| i < 3 }.should eql Stream[4, 1, 5]
        end
      end
    end
    
    describe 'reject' do
      
      subject { Stream[4, 1, 5, 6, 2, 7, 3, 8] }
      
      context 'with a block' do
        it 'should return all the elements that do not fit the predicate' do
          subject.reject {|_| _ > 3 }.should eql Stream[1, 2, 3]
        end
      end
      context 'with no block' do
        it 'should return a selecting iterator' do
          subject.reject.with_index {|_, i| i > 2 }.should eql Stream[4, 1, 5]
        end
      end
    end
  end
  
  context 'when created with #from' do
    
    subject { Stream.from(2) }
    
    it 'should count up from the initial value' do
      subject.take(100).should == Stream[*(2...102)]
    end
    
    describe 'map' do
      it 'should apply the block to each element lazily' do
        subject.map {|_| _ * 2 }.take(3).should eql Stream[4, 6, 8]
      end
    end
    
    describe 'select' do
      it 'should test the elements lazily' do
        subject.select {|_| _.even? }.take(3).should eql Stream[2, 4, 6]
      end
    end
    
    describe 'reject' do
      it 'should test the elements lazily' do
        subject.reject {|_| _.even? }.take(3).should eql Stream[3, 5, 7]
      end
    end
  end
  
  describe 'iterator' do
    
    subject { Stream[1, 2, 3].iterator }
    
    let(:values) { [1, 2, 3] }
    
    it_should_behave_like 'all iterators'
    
    describe 'select' do
      let(:bigger_stream) { Stream[4, 1, 5, 6, 2, 7, 3, 8] }
      it 'should return all the elements that fit the predicate' do
        bigger_stream.iterator.select {|_| _ < 4 }.should == Stream[1, 2, 3]
      end
    end
    
    describe 'reject' do
      let(:bigger_stream) { Stream[4, 1, 5, 6, 2, 7, 3, 8] }
      it 'should return all the elements that do not fit the predicate' do
        bigger_stream.iterator.reject {|_| _ > 3 }.should == Stream[1, 2, 3]
      end
    end
  end
  
end
