class GenericEntity
  def initialize(kwargs)
    eigen = class << self; self; end
    kwargs.each do |k, v|
      eigen.class_eval {  attr_accessor k }
      instance_variable_set "@#{k}", v
    end
  end
end 

g = GenericEntity.new(:aaa=>1, :bbb=>2)
puts g.aaa
