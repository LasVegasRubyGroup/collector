module Enumerable
  unless instance_methods.include?(:scan_left)
    def scan_left(a)
      as = [a]
      each do |_|
        a = yield a, _
        as << a
        a
      end
      as
    end
  end
end
