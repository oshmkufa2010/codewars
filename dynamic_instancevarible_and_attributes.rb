require 'test/unit'

class GenericEntity
	def initialize(kwargs)
 		eigen = class << self; self; end
    kwargs.each do |k, v|
    	eigen.class_eval {  attr_accessor k }
    	instance_variable_set "@#{k}", v
    end 
	end
end

class TestGenericEntity < Test::Unit::TestCase
  def test_simple
    car = GenericEntity.new(:color => "black", :engine => "V8")
    assert_equal(car.color, "black")
  end
end
