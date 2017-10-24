class SuperFoo
  attr_accessor :data

  def initialize
    @data = {}
  end

  def self.data_accessor(*args)
    args.each do |attr|
      define_method attr do
        @data[attr]
      end

      define_method "#{attr}=" do |value|
        @data[read_name] = value
      end
    end
  end
end

class SubFoo < SuperFoo
  data_accessor :fizz, :pi
end

foo = SubFoo.new

puts foo.respond_to? 'fizz'
puts foo.respond_to? 'fizz='
