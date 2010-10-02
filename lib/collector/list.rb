require 'collector/generic/sequence'
require 'collector/generic/iterator'

class List < Collector::Generic::Sequence
  
  def self.empty
    @@empty ||= List.new(nil, nil)
  end
  
  def self.[](*items)
    l = empty
    items.reverse_each {|_| l = self.new(_, l) }
    l
  end
  
  def initialize(head, tail)
    @head = head
    @tail = tail
    @size = empty? ? 0 : tail.size + 1
  end
  
  attr_reader :head, :tail, :size
  
  def empty?
    @tail.nil?
  end
  
  def iterator
    Iterator.new(self)
  end
  
  def reverse
    inject(List.empty) {|a, _| List.new(_, a) }
  end
  
  def to_s
    inspect
  end
  
  def inspect
    "List#{to_a.inspect}"
  end
  
  protected
  
  def new_builder
    Builder.new
  end
  
  class Iterator < Collector::Generic::Iterator
    
    def initialize(list)
      @list = list
      rewind
    end
    
    def next
      if @tail.empty?
        rewind
        raise StopIteration
      else
        x = @tail.head
        @tail = @tail.tail
        x
      end
    end
    
    def peek
      raise StopIteration if @tail.empty?
      @tail.head
    end
    
    def rewind
      @tail = @list
    end
    
    protected
    
    def __iterable__
      @list
    end
    
  end
  
  class Builder
    def initialize
      @l = List.empty
    end
    def << e
      @l = List.new(e, @l)
      self
    end
    def result
      @l.reverse
    end
  end
  
end
