def spiralize(size)
  #your code heres
  size.step(1, -4).reverse.reduce([]) do |acc, s|
    case s
    when 1
      [[1]]
    when 2
      [[1,1],
       [0,1]]
    when 3
      [[1,1,1],
      [0,0,1],
      [1,1,1]]
    when 4
      [[1,1,1,1],
      [0,0,0,1],
      [1,0,0,1],
      [1,1,1,1]]
    else
      result = Array.new(s) do
        Array.new(s, 0)
      end
      (0..s).to_a.product((0..s).to_a).each do |i, j|
        # TODO
      end
    end
  end
end
