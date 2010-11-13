module Enumerable
  unless method_defined?(:scan_right)
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
