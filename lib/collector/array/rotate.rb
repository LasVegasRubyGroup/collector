class Array
  unless instance_methods.include?(:rotate)
    def rotate(n = 1)
      new_start = n % self.size
      self[new_start..-1] + self[0...new_start]
    end
  end
end
