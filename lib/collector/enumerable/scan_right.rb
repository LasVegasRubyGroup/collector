module Enumerable
  unless instance_methods.include?(:scan_right)
    def scan_right(a)
      as = [a]
      reverse_each do |_|
        a = yield _, a
        as << a
        a
      end
      as
    end
  end
end
