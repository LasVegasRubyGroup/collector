require "spec_helper"

describe "Collector" do
  describe "Array" do
    describe "Rotate" do
      it "should append the first value" do
        [2,3,1].should == [1,2,3].rotate
      end

      it "should rotate the number of times given" do
        [3,1,2].should == [1,2,3].rotate(2)
      end
    end
  end
end
