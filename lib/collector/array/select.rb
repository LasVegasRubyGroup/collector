class Array
  unless method_defined?(:select!)
    def select!(&block)
      self.replace(select(&block))
    end
  end
end
