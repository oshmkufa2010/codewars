module AttrLazy

  def attr_lazy(name, &block)
    attr_name = (name.to_s.end_with? '?') ? name.to_s[0...-1] : name.to_s

    define_method name do |*args|
      if self.instance_variable_defined? "@#{attr_name}"
        return self.instance_variable_get("@#{attr_name}")
      end
      result = self.instance_eval &block
      self.instance_variable_set("@#{attr_name}", result)
      result
    end
  end

end

class Numbers
  extend AttrLazy

  def initialize(*numbers)
    @numbers = numbers
  end

  attr_lazy :numbers do
    @numbers
  end

  attr_lazy :evens do
    @numbers.select(&:even?)
  end

  attr_lazy :even? do
    @numbers.all?(&:even?)
  end

  def mark_even
    @even = true
  end
end

n = Numbers.new 1, 2, 3, 4
n.numbers
# n.mark_even
puts n.even?
