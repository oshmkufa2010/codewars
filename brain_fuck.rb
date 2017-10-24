def brain_luck(code, input)
  output = ''
  # code here
  cells = [0] * 30000
  insts = []
  stack = []
  i = 1
  code.each_char do |ch|
    case ch
      when '[' then
        stack << i
        insts << i
        i += 1
      when ']' then 
        j = stack.pop
        insts << j
      else insts << ch
    end
  end
  ptr = 0
  ip = 0
  input_iter = input.split('').to_enum
  begin
    while ip < insts.size
      inst = insts[ip]
      case inst
        when '>' then ptr = (ptr + 1) % cells.size
        when '<' then ptr = (ptr - 1) % cells.size 
        when '+' then cells[ptr] = (cells[ptr] + 1) % 256 
        when '-' then cells[ptr] = (cells[ptr] - 1) % 256 
        when '.' then output += cells[ptr].chr 
        when ',' then cells[ptr] = input_iter.next.ord
        else
          if inst > 0 then
            if cells[ptr] == 0 then
              while (insts[ip].is_a? String) || (insts[ip] + inst != 0)
                ip += 1
              end
            end
          elsif inst < 0 then
            if cells[ptr] != 0 then
              while (insts[ip].is_a? String) || (insts[ip] + inst != 0)
                insts[ip]
                ip -= 1
              end
            end
          end
      end
      ip += 1
    end
  rescue
    return output
  end
  output
end

puts brain_luck(',+[-.,+]', 'Codewars' + 255.chr)
puts brain_luck(',[.[-],]', 'Codewars' + 0.chr)