require 'collector/list'
require 'collector/shared_sequence_examples'
require 'collector/shared_iterator_examples'

describe List do
  
  context 'when constructed empty' do
    
    subject { List[] }
    
    let(:values) { [] }
    
    it_should_behave_like 'all sequences'
    
    it "should say it's empty" do
      subject.should be_empty
    end
  end
  
  context 'when constructed with items' do
    
    subject { List[1, 2, 3] }
    
    let(:values) { [1, 2, 3] }
    
    it_should_behave_like 'all non-empty sequences'
    
    it 'should equal another List of the same items' do
      subject.should == List[1, 2, 3]
    end
    
    describe 'head' do
      it 'should return the first item' do
        subject.head.should == 1
      end
    end
    
    describe 'tail' do
      it 'should return a List of all but the first item' do
        subject.tail.should == List[2, 3]
      end
    end
    
    describe 'select' do
      
      subject { List[4, 1, 5, 6, 2, 7, 3, 8] }
      
      context 'with a block' do
        it 'should return all the elements that fit the predicate' do
          subject.select {|_| _ < 4 }.should eql List[1, 2, 3]
        end
      end
      context 'with no block' do
        it 'should return a selecting iterator' do
          subject.select.with_index {|_, i| i < 3 }.should eql List[4, 1, 5]
        end
      end
    end
    
    describe 'reject' do
      
      subject { List[4, 1, 5, 6, 2, 7, 3, 8] }
      
      context 'with a block' do
        it 'should return all the elements that do not fit the predicate' do
          subject.reject {|_| _ > 3 }.should eql List[1, 2, 3]
        end
      end
      context 'with no block' do
        it 'should return a selecting iterator' do
          subject.reject.with_index {|_, i| i > 2 }.should eql List[4, 1, 5]
        end
      end
    end
  end
  
  describe 'iterator' do
    
    subject { List[1, 2, 3].iterator }
    
    let(:values) { [1, 2, 3] }
    
    it_should_behave_like 'all iterators'
    
    describe 'select' do
      let(:bigger_list) { List[4, 1, 5, 6, 2, 7, 3, 8] }
      it 'should return all the elements that fit the predicate' do
        bigger_list.iterator.select {|_| _ < 4 }.should eql List[1, 2, 3]
      end
    end
    
    describe 'reject' do
      let(:bigger_list) { List[4, 1, 5, 6, 2, 7, 3, 8] }
      it 'should return all the elements that do not fit the predicate' do
        bigger_list.iterator.reject {|_| _ > 3 }.should eql List[1, 2, 3]
      end
    end
    
  end
  
end
