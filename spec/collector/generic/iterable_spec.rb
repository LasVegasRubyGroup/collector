require 'collector/generic/iterable'
require 'collector/shared_iterable_examples'

describe Collector::Generic::Iterable do
  
  class TestCollection
    include Collector::Generic::Iterable
    def initialize(values)
      @values = values
    end
    def iterator
      @values.each
    end
    def new_builder
      Builder.new
    end
    class Builder < Collector::Generic::Iterable::ArrayBuilder
      def result
        TestCollection.new(super)
      end
    end
  end
  
  subject { TestCollection.new(values) }
  
  let(:values) { [1, 2, 3] }
  
  it_behaves_like 'any iterable that is not an iterator'
  
end
