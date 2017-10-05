class Foo
    def initialize( bar )
      # Save the value as an instance variable
      @bar = bar
    end
    def unchanged1
      yield if block_given? # call the block with its original scope
    end
    def unchanged2( &block )
      block.call            # another way to do it
    end
    def changeself( &block )
      # run the block in the scope of self
      self.instance_eval &block
    end
end
  
@bar = 17
f = Foo.new( 42 )
f.unchanged1{ p self } #=> 17
f.unchanged2{ p self } #=> 17
f.changeself{ p self } #=> 42