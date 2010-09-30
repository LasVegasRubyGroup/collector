require "collector/array/rotate"

Array.send(:include, Collector::Array::Rotate) unless Array.instance_methods.include?("rotate")
