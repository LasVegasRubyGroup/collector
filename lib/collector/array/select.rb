class Array
  unless instance_methods.include?(:select!)
    def select!(&block)
      self.replace(select(&block))
    end
  end
end
