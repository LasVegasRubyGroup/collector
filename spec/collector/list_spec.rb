require 'collector/list'
require 'collector/shared_sequence_examples'
require 'collector/shared_iterator_examples'

describe List do
  
  context 'when empty' do
    subject { List[] }
    let(:values) { [] }
    it_behaves_like 'any sequence'
  end
  
  context 'with items' do
    subject { List[1, 2, 3] }
    let(:values) { [1, 2, 3] }
    it_behaves_like 'a non-empty sequence'
  end
  
  describe '#head' do
    
    subject { List[1, 2, 3] }
    
    it 'returns a List of all but the first item' do
      subject.head.should == 1
    end
    
    context 'when the list is empty' do
      
      subject { List[] }
      
      it 'returns nil' do
        subject.head.should == nil
      end
    end
  end
  
  describe '#tail' do
    
    subject { List[1, 2, 3] }
    
    it 'returns the first item' do
      subject.tail.should == List[2, 3]
    end
    
    context 'when the list is empty' do
      
      subject { List[] }
      
      it 'returns nil' do
        subject.tail.should == nil
      end
    end
  end
  
  describe '#select' do
    
    subject { List[4, 1, 5, 6, 2, 7, 3, 8] }
    
    context 'with a block given' do
      it 'returns all the elements that fit the predicate' do
        subject.select {|_| _ < 4 }.should eql List[1, 2, 3]
      end
    end
    context 'with no block given' do
      it 'returns a selecting iterator' do
        subject.select.with_index {|_, i| i < 3 }.should eql List[4, 1, 5]
      end
    end
  end
  
  describe '#reject' do
    
    subject { List[4, 1, 5, 6, 2, 7, 3, 8] }
    
    context 'with a block given' do
      it 'returns all the elements that do not fit the predicate' do
        subject.reject {|_| _ > 3 }.should eql List[1, 2, 3]
      end
    end
    context 'with no block given' do
      it 'returns a selecting iterator' do
        subject.reject.with_index {|_, i| i > 2 }.should eql List[4, 1, 5]
      end
    end
  end
  
  describe '#iterator' do
    
    subject { List[1, 2, 3].iterator }
    
    let(:values) { [1, 2, 3] }
    
    it_behaves_like 'any iterator'
    
    describe '#select' do
      let(:bigger_list) { List[4, 1, 5, 6, 2, 7, 3, 8] }
      it 'returns all the elements that fit the predicate' do
        bigger_list.iterator.select {|_| _ < 4 }.should eql List[1, 2, 3]
      end
    end
    
    describe '#reject' do
      let(:bigger_list) { List[4, 1, 5, 6, 2, 7, 3, 8] }
      it 'returns all the elements that do not fit the predicate' do
        bigger_list.iterator.reject {|_| _ > 3 }.should eql List[1, 2, 3]
      end
    end
  end
  
  describe '#empty?' do
    context 'when the list is empty' do
      
      subject { List[] }
      
      it 'returns true' do
        subject.should be_empty
      end
    end
    
    context 'when the list is not empty' do
      
      subject { List[1, 2, 3] }
      
      it 'returns false' do
        subject.should_not be_empty
      end
    end
  end
  
  describe '==' do
    
    subject { List[1, 2, 3] }
    
    context 'given another List with the same elements' do
      it 'returns true' do
        subject.should == List[1, 2, 3]
      end
    end
  end
  
end
