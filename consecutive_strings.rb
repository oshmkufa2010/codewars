def longest_consec(strarr, k)
    return "" unless strarr.size > 0 and k <= strarr.size and k > 0
    init = strarr[0...k].map{|x| x.size }.reduce(0){|x, y| x + y}
    max = init
    max_index = k - 1
    pre = init
    strarr[k..-1].each_with_index do |str, i|
        i = i + k
        cur = pre - strarr[i-k].size + str.size
      if cur > max then
      	max = cur
        max_index = i
      end
      pre = cur
    end
    return strarr[max_index-k+1..max_index].join('')
end

puts longest_consec(["ejjjjmmtthh", "zxxuueeg", "aanlljrrrxx", "dqqqaaabbb", "oocccffuucccjjjkkkjyyyeehh"], 1)