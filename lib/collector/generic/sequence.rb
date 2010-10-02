require 'collector/generic/iterable'

module Collector
  module Generic
    class Sequence
      include Iterable
      
      def same_contents?(other)
        self.corresponds?(other) {|a, b| a == b }
      end
      
      def ==(other)
        if other.is_a?(Sequence)
          other.can_equal?(self) && same_contents?(other)
        elsif other.respond_to?(:to_ary) or other.is_a?(Range)
          same_contents?(other)
        end
      end
      
      def eql?(other)
        other.instance_of?(self.class) && same_contents?(other)
      end
      
      def can_equal?(other)
        other.is_a?(Sequence) or
        other.respond_to?(:to_ary) or
        other.is_a?(Range)
      end
      
    end
  end
end
