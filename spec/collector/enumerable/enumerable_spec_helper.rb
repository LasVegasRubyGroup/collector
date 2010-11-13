module EnumerableSpecHelper
  
  class TestEnumerable
    
    include Enumerable
    
    def initialize(values)
      @values = values
    end
    
    def each
      if block_given?
        @values.each {|_| yield _ }
      else
        @values.each
      end
    end
    
  end
  
end
