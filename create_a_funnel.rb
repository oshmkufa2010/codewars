class Funnel
  def initialize
    @container = [nil] * 15
  end
  
  def index(i, j)
    @container[i*(i+1)/2 + j]
  end
  
  def set_value(i, j, val)
    @container[i*(i+1)/2 + j] = val
  end
  
  def weight(i, j)
    q = Queue.new 
    q.push([i, j])
    visited_record = [false] * 21 
    visited = lambda {|x, y| visited_record[x*(x+1)/2 + y] }
    visite = lambda {|x, y| visited_record[x*(x+1)/2 + y] = true}
    result = 0
    while !q.empty? do 
      x, y = q.pop
      unless index(x, y).nil?
        result += 1
        [[x+1, y], [x+1, y+1]].each do |a, b|
          unless visited.(a, b)
            visite.(a, b)
            q.push([a, b])
          end
        end
      end
    end
    result 
  end
  
  def fill(*args)
    args.each do |arg|
      i = @container.find_index{|x| x.nil? }
      @container[i] = arg unless i.nil?
    end
  end
  
  def remove(i, j)
    x, y = if index(i+1, j).nil? && index(i+1, j+1).nil?
      [nil, nil]
    else 
      if index(i+1, j).nil?
        [i+1, j+1]
      elsif index(i+1, j+1).nil?
        [i+1, j]
      else
        [[i+1, j+1], [i+1, j]].sort_by{|x, y| weight(x, y)}.last
      end
    end
    if x.nil? && y.nil?
      set_value(i, j, nil)
    else
      n_v = index(x, y) 
      remove(x, y)
      set_value(i, j, n_v)
    end
  end
  
  def drip
    v = index(0, 0)
    remove(0, 0)
    v
  end
  
  def to_s
    result = []
    4.downto(0) do |i|
      s = ' ' * (4-i) + "\\"
      nums = []
      0.upto(i) do |j|
        v = index(i, j)
        nums << (v.nil? ? ' ' : v.to_s) 
      end
      s += nums.join(' ')
      s += '/'
      result << s
    end
    result.join("\n")
  end
end
