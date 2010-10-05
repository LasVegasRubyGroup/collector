module Enumerable
  alias_method :fold_left, :inject unless instance_methods.include?(:fold_left)
  alias_method :reduce_left, :inject unless instance_methods.include?(:reduce_left)
  alias_method :filter, :select unless instance_methods.include?(:filter)
  alias_method :filter_not, :reject unless instance_methods.include?(:filter_not)
  alias_method :take_left, :take unless instance_methods.include?(:take_left)
end
