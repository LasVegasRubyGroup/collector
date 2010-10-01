module Enumerable
  unless instance_methods.include?(:each_with_object)
    def each_with_object(o)
      if block_given?
        each {|_| yield _, o }
        o
      else
        to_enum :each_with_object, o
      end
    end
  end
end
