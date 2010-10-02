require 'collector/list'
require 'collector/generic/iterator'

class Stream < List
  
  def self.empty
    @@empty ||= Stream.new(nil, nil)
  end
  
  def self.[](*items)
    if items.empty?
      empty
    else
      first, *rest = items
      self.new(first) { self[*rest] }
    end
  end
  
  def self.iterate(initial)
    self.new(initial) { self.iterate(yield initial) {|_| yield _ } }
  end
  
  def self.from_enum(e)
    self.new(e.next) { self.from_enum(e) }
  rescue StopIteration
    self.empty
  end
  
  def self.from(n)
    self.new(n) { self.from(n + 1) }
  end
  
  def initialize(head, tail_f=nil, &block)
    @head = head
    @tail_f = block_given? ? block : tail_f
  end
  
  attr_reader :head
  
  def tail
    @tail ||= @tail_f.call unless empty?
  end
  
  def empty?
    @tail_f.nil?
  end
  
  def size
    @size ||= inject(0) {|a, _| a + 1 }
  end
  
  def reverse
    inject(Stream.empty) {|a, _| Stream.new(_) { a } }
  end
  
  def force
    self.each {}
    self
  end
  
  def inspect
    a = []
    s = self
    rest = loop do
      break '...' if s.nil?
      break '' if s.empty?
      a << s.head.inspect
      s = s.instance_variable_get(:@tail)
    end
    'Stream[' + a.join(', ') + rest + ']'
  end
  
  protected
  
  def __map__
    Stream.from_enum(Collector::Generic::MappingIterator.new(iterator) {|_| yield _ })
  end
  
  def __select__
    Stream.from_enum(Collector::Generic::SelectingIterator.new(iterator) {|_| yield _ })
  end
  
  def __reject__
    Stream.from_enum(Collector::Generic::RejectingIterator.new(iterator) {|_| yield _ })
  end
  
  def new_builder
    Builder.new
  end
  
  class Builder
    def initialize
      @s = Stream.empty
    end
    def << e
      tail = @s
      @s = Stream.new(e) { tail }
      self
    end
    def result
      @s.reverse
    end
  end
  
  private
  
  def each_evaluated
    s = self
    while s
      yield s
      s = s.instance_variable_get(@tail)
    end
  end
  
end
