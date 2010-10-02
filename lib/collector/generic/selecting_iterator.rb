require 'collector/generic/iterator'

module Collector
  module Generic
    class SelectingIterator < Iterator
      
      def initialize(iter, &f)
        @iter = iter
        @f = f
      end
      
      def next
        loop do
          x = @iter.next
          return x if @f.call(x)
        end
        raise StopIteration
      end
      
      def peek
        loop do
          return @iter.peek if @f.call(@iter.peek)
          @iter.next
        end
        raise StopIteration
      end
      
      def with_index
        @iter.with_index.select {|_| p _; yield _ }.map {|_,| _ }
      end
      
      def with_object
        @iter.with_object.select {|_, o| yield _, o }.map {|_,| _ }
      end
      
      protected
      
      def __each__
        @iter.each {|_| yield _ if @f.call(_) }
      end
      
    end
  end
end
