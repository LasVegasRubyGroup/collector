class Array
  
  unless instance_methods.include?(:flat_map)
    def flat_map
      self.map {|_| yield _ }.flatten(1)
    end
  end
  
  unless instance_methods.include?(:collect_concat)
    alias collect_concat flat_map
  end
  
end
