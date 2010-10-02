require 'collector/generic/iterator'

module Collector
  module Generic
    class MappingIterator < Iterator
      
      def initialize(iter, &f)
        @iter = iter
        @f = f
      end
      
      def next
        @f.call(@iter.next)
      end
      
      def peek
        @f.call(@iter.peek)
      end
      
      def with_index
        @iter.with_index.map {|_, i| yield _, i }
      end
      
      def with_object
        @iter.with_object.map {|_, o| yield _, o }
      end
      
      protected
      
      def __each__
        @iter.each {|_| yield @f.call(_) }
      end
      
    end
  end
end
