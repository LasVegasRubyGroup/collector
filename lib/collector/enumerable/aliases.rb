module Enumerable
  alias_method :fold_left, :inject unless method_defined?(:fold_left)
  alias_method :reduce_left, :inject unless method_defined?(:reduce_left)
  alias_method :filter, :select unless method_defined?(:filter)
  alias_method :filter_not, :reject unless method_defined?(:filter_not)
  alias_method :take_left, :take unless method_defined?(:take_left)
end
