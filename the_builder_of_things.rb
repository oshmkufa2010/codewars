class Chain
  def initialize(*args)
    @chains = []
  end
  def method_missing(*args)
    
  end
end

class Thing
  def initialize(*args)
    @methods = []
  end

  def method_missing(*args)
  end
end