require 'collector/generic/iterable'
require 'collector/generic/iterator'

module Collector
  module Generic
    class WithIndexIterator < Iterator
      
      def initialize(iter)
        @iter = iter
        @index = 0
      end
      
      def next
        i = @index
        @index += 1
        [@iter.next, i]
      rescue StopIteration
        rewind
        raise
      end
      
      def peek
        [@iter.peek, @index]
      rescue StopIteration
        rewind
        raise
      end
      
      def rewind
        @iter.rewind
        @index = 0
      end
      
      protected
      
      def __each__
        index = -1
        @iter.each {|_| yield [_, (index += 1)] }
      end
      
      def __map__
        index = -1
        @iter.map {|_| yield [_, (index += 1)] }
      end
      
      def __select__
        index = -1
        @iter.select {|_| yield [_, (index += 1)] }
      end
      
      def __reject__
        index = -1
        @iter.reject {|_| yield [_, (index += 1)] }
      end
      
    end
  end
end
