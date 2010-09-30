require "spec_helper"

describe "Array" do
  describe "rotate" do
    it "should append the first value" do
      [1,2,3].rotate.should == [2,3,1]
    end

    it "should rotate the number of times given" do
      [1,2,3].rotate(2).should == [3,1,2]
    end
  end

  describe "rotate!" do
    it "should modify itself" do
      array = [1,2,3]
      array.rotate!
      array.should == [2,3,1]
    end
  end
end
