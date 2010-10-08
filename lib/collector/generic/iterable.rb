module Collector
  module Generic
    
    autoload :MappingIterator, 'collector/generic/mapping_iterator'
    autoload :SelectingIterator, 'collector/generic/selecting_iterator'
    autoload :RejectingIterator, 'collector/generic/rejecting_iterator'
    
    module Iterable
      
      include Enumerable
      
      def each
        if block_given?
          __each__ {|_| yield _ }
        else
          iterator
        end
      end
      
      def to_enum(method = :each, *args)
        if method == :each and args.empty?
          iterator
        else
          super
        end
      end
      
      alias enum_for to_enum
      
      def map
        if block_given?
          __map__ {|_| yield _ }
        else
          MappingIterator.new(iterator)
        end
      end
      
      alias collect map
      
      def select
        if block_given?
          __select__ {|_| yield _ }
        else
          SelectingIterator.new(iterator)
        end
      end
      
      alias filter select
      
      def reject
        if block_given?
          __reject__ {|_| yield _ }
        else
          RejectingIterator.new(iterator)
        end
      end
      
      alias filter_not reject
      
      def take(n)
        build do |b|
          e = self.each
          n.times { b << e.next } rescue StopIteration
        end
      end
      
      def corresponds?(other)
        if self.count == other.count
          e = other.each
          self.all? {|_| yield(_, e.next) }
        end
      end
      
      def zip(*others)
        es = others.map {|_| _.each }
        if block_given?
          self.each {|_| yield([_, *es.map {|e| next_or_nil e }]) }
        else
          map {|_| [_, *es.map {|e| next_or_nil e }] }
        end
      end
      
      def reverse
        build {|b| reverse_each {|_| b << _ } }
      end
      
      protected
      
      def __each__
        i = iterator
        loop { yield i.next }
      end
      
      def __map__
        build {|b| self.each {|_| b << yield(_) } }
      end
      
      def __select__
        build {|b| each {|_| b << _ if yield(_) } }
      end
      
      def __reject__
        build {|b| each {|_| b << _ unless yield(_) } }
      end
      
      def build
        b = new_builder
        yield b
        b.result
      end
      
      def new_builder
        ArrayBuilder.new
      end
      
      private
      
      def next_or_nil(e)
        e.next
      rescue StopIteration
        nil
      end
      
      class ArrayBuilder
        def initialize
          @a = []
        end
        def << e
          @a << e
          self
        end
        def result
          @a
        end
      end
      
    end
  end
end
