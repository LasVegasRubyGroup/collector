class Array
  
  unless method_defined?(:flat_map)
    def flat_map
      self.map {|_| yield _ }.flatten(1)
    end
  end
  
  unless method_defined?(:collect_concat)
    alias collect_concat flat_map
  end
  
end
