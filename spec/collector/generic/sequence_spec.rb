require 'collector/generic/sequence'
require 'collector/shared_sequence_examples'

describe Collector::Generic::Sequence do
  
  class TestSequence < Collector::Generic::Sequence
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
        TestSequence.new(super)
      end
    end
  end
  
  subject { TestSequence.new(values) }
  
  let(:values) { [1, 2, 3] }
  
  it_should_behave_like 'all non-empty sequences'
  
end
