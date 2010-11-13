require "spec_helper"

describe "Array" do
  
  describe "#flat_map" do
    it "maps, then concatenates the results" do
      %w{a b c}.flat_map {|s| (1..3).map {|i| "#{s}#{i}" } }.should ==
        %w{a1 a2 a3 b1 b2 b3 c1 c2 c3}
    end
  end
  
  describe "#collect_concat" do
    it "maps, then concatenates the results" do
      %w{a b c}.collect_concat {|s| (1..3).collect {|i| "#{s}#{i}" } }.should ==
        %w{a1 a2 a3 b1 b2 b3 c1 c2 c3}
    end
  end
  
end
