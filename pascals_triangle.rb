def pascalsTriangle(n)
	return [1] unless n > 1
	(2...n).reduce([[1], [1, 1]]) do |result, i|
  	pre_line = result.last
    line = [1]
    pre_line[1..-1].each_with_index do |number, index|
    	line << (number + pre_line[index])
    end
    line << 1
    result << line
  end.flatten
end

puts pascalsTriangle(4)
