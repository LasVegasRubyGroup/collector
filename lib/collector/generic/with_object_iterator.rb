require 'collector/generic/iterable'
require 'collector/generic/iterator'

module Collector
  module Generic
    class WithObjectIterator < Iterator
      
      def initialize(iter, obj)
        @iter = iter
        @obj = obj
      end
      
      def next
        [@iter.next, @obj]
      end
      
      def peek
        [@iter.peek, @obj]
      end
      
      protected
      
      def __each__
        @iter.each {|_| yield [_, @obj] }
      end
      
      def __map__
        @iter.map {|_| yield [_, @obj] }
      end
      
      def __select__
        @iter.select {|_| yield [_, @obj] }
      end
      
      def __reject__
        @iter.reject {|_| yield [_, @obj] }
      end
      
    end
  end
end
