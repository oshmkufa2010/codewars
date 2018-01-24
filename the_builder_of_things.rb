# imported to handle any plural/singular conversions
require 'active_support/core_ext/string'

class BooleanDefiner
  def initialize(host, negative)
    @host = host
    @negative = negative
  end
  
  def method_missing(method_name, *args)
    result = !@negative
    @host.define_singleton_method "#{method_name}?" do
      result
    end
  end
end

class PropertyDefiner
  def initialize(host) 
    @host = host
  end
  
  def method_missing(attr_name)
    host = @host
    eigen_cls = class << host; self; end
    eigen_cls.send :attr_accessor, attr_name
    c = Class.new do
      define_method :method_missing do |attr_value|
        host.send "#{attr_name}=", attr_value.to_s 
        host
      end
    end
    c.new
  end
end

class Things < Array
  alias ori_each each
  def each(&proc)
    ori_each do |thing|
      thing.instance_eval(&proc) 
    end
  end
end


class ChildDefiner
  def initialize(host, child_size)
    @host = host
    @child_size = child_size
  end
  
  def method_missing(child_name)
    host = @host
    child_size = @child_size
    ts = if child_size >= 2
      Things.new(child_size) do 
        t = Thing.new(child_name.to_s.singularize)
        t.is_a.send child_name.to_s.singularize
        t
      end
    else
      t = Thing.new(child_name.to_s.singularize)
      t.is_a.send child_name.to_s.singularize
      t
    end
    host.define_singleton_method child_name do
      ts
    end
    ts
  end
  
end

class MethodDefiner
  def initialize(host)
    @host = host
  end

  def method_missing(method_name, method_alias=nil, &proc)
    unless method_alias.nil?
      eigen_cls = class << @host; self; end
      var_name = "@#{method_alias}"
      eigen_cls.send :attr_accessor, method_alias.to_sym
      @host.send "#{method_alias}=", []
    end
    @host.define_singleton_method method_name do |*args|
      result = instance_exec(*args, &proc)
      if method_alias
        instance_variable_get(var_name) << result
      end
      result
    end
  end
end

class Thing
  attr_reader :name
  
  def initialize(name)
    @name = name.to_s
  end
  
  def is_a
    BooleanDefiner.new(self, false)
  end
  
  def is_not_a
    BooleanDefiner.new(self, true)
  end
  
  def is_the
    PropertyDefiner.new(self)
  end
  
  def has(child_size)
    ChildDefiner.new(self, child_size)
  end
  
  alias having has
  alias being_the is_the
  alias and_the being_the
  
  def can
    MethodDefiner.new(self)
  end
  
end