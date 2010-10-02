require 'collector/generic/iterator'

module Collector
  module Generic
    class RejectingIterator < Iterator
      
      def initialize(iter, &f)
        @iter = iter
        @f = f
      end
      
      def next
        loop do
          x = @iter.next
          return x unless @f.call(x)
        end
        raise StopIteration
      end
      
      def peek
        loop do
          return @iter.peek unless @f.call(@iter.peek)
          @iter.next
        end
        raise StopIteration
      end
      
      def with_index
        @iter.with_index.reject {|_, i| yield _, i }
      end
      
      def with_object
        @iter.with_object.reject {|_, o| yield _, o }
      end
      
      protected
      
      def __each__
        @iter.each {|_| yield _ unless @f.call(_) }
      end
      
    end
  end
end
