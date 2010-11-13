require "spec_helper"

describe 'Array' do
  describe '#rotate' do
    context 'given no arguments' do
      it "removes and appends the first value" do
        [1,2,3].rotate.should == [2,3,1]
      end
    end
    
    context 'given a positive number' do
      it 'rotates the number of times given' do
        [1,2,3].rotate(2).should == [3,1,2]
      end
    end
    
    context 'given a negative number' do
      it 'rotates in the other direction' do
        [1,2,3].rotate(-1).should == [3,1,2]
      end
    end
  end

  describe '#rotate!' do
    it 'modifies itself' do
      array = [1,2,3]
      array.rotate!
      array.should == [2,3,1]
    end
  end
end
