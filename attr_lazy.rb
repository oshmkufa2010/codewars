module AttrLazy

    def attr_lazy(name, &block)
        origin_name = name
        name = if name.to_s.end_with? '?'  then name.to_s[0...-1].to_sym else name end

        define_method origin_name do |*args|
          if self.instance_variable_defined? "@#{name}" then
            return self.instance_variable_get("@#{name}")
          end
          result = self.instance_eval &block
          self.instance_variable_set("@#{name}", result)
          return result
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
n.mark_even
puts n.even?