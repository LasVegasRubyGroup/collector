require "spec_helper"

describe "Array" do
  describe "#select!" do
    it "modifies itself" do
      array = %w{ a b c d e f }
      array.select! { |v| v =~ /[aeiou]/ }
      array.should == [ "a", "e" ]
    end
  end
end
