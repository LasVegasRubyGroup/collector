module Collector
  module Generic
    
    autoload :Iterable, 'collector/generic/iterable'
    autoload :WithIndexIterator, 'collector/generic/with_index_iterator'
    autoload :WithObjectIterator, 'collector/generic/with_object_iterator'
    autoload :MappingIterator, 'collector/generic/mapping_iterator'
    autoload :SelectingIterator, 'collector/generic/selecting_iterator'
    autoload :RejectingIterator, 'collector/generic/rejecting_iterator'
    
    class Iterator
      include Iterable
      
      def iterator
        self
      end
      
      def next_values
        _ = self.next
        _.respond_to?(:to_ary) ? _ : [_]
      end
      
      def peek_values
        _ = self.peek
        _.respond_to?(:to_ary) ? _ : [_]
      end
      
      def with_index
        if block_given?
          __iterable__.each_with_index {|_, i| yield(_, i) }
        else
          WithIndexIterator.new(self)
        end
      end
      
      def with_object(o)
        if block_given?
          __iterable__.each_with_object(o) {|_, o| yield(_, o) }
        else
          WithObjectIterator.new(self, o)
        end
      end
      
      def same_contents?(other)
        self.corresponds?(other) {|a, b| a == b }
      end
      
      def ==(other)
        other.respond_to?(:next) &&
        other.can_equal?(self) &&
        same_contents?(other)
      end
      
      def eql?(other)
        other.instance_of?(self.class) && same_contents?(other)
      end
      
      def can_equal?(other)
        other.respond_to?(:next)
      end
      
      protected
      
      def __each__
        __iterable__.each {|_| yield _ }
      end
      
      def __map__
        __iterable__.map {|_| yield _ }
      end
      
      def __select__
        __iterable__.select {|_| yield _ }
      end
      
      def __reject__
        __iterable__.reject {|_| yield _ }
      end
      
    end
  end
end
