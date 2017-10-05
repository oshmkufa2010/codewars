require 'pry'

def justify(text, width)
  words = text.split(' ')
  lines = []
  i = 0
  while true do
    line = []
    line_len = 0
    while i < words.size and line_len < width do
      word = words[i]
      if word.size + line_len > width then
        break
      end
      line_len += (word.size + 1)
      line << word 
      i += 1
    end
    if i >= words.size then
      lines << line.join(" ")
      break
    end
    gap_count = line.size - 1
    line_size = line.map { | w | w.size }.reduce(0,  &:+)
    diff = width - line_size
    avag = diff / gap_count
    res = diff % gap_count
    gaps = Array.new(gap_count, " " * avag)
    gaps = gaps[0...res].map{|sp| sp+" " } + gaps[res..-1]
    lines << line.zip(gaps).flatten.compact.join("")
  end
  lines.join("\n")
end

def justify2(text, width)
  formated = text.split.reduce([[]]) do |lines, word|
    line = lines.last
    line_size = line.reduce(0){|sum, w|sum + w.size} + line.size - 1
    if line_size + word.size + 1 <= width then
      line << word
      lines
    else
      lines << [word]
    end
  end

  head = formated[0...-1].map do |line|
    line_size = line.reduce(0){|sum, w| sum + w.size } + line.size - 1
    gap_size = line.size - 1
      if gap_size > 0 then 
        diff = width - line_size
        avg = diff / gap_size
        res = diff % gap_size 
        gaps = Array.new(gap_size, " " * (avg+1))
        gaps = gaps[0...res].map{|sp| sp + " "} + gaps[res..-1]
        line.zip(gaps).flatten.compact.join("")
      else
        line[0]
      end
  end
  head << formated[-1].join(" ")
  head.join("\n") 
end

s = "Lorem  ipsum  dolor  sit amet,
consectetur  adipiscing  elit.
Vestibulum    sagittis   dolor
mauris,  at  elementum  ligula
tempor  eget.  In quis rhoncus
nunc,  at  aliquet orci. Fusce
at   dolor   sit   amet  felis
suscipit   tristique.   Nam  a
imperdiet   tellus.  Nulla  eu
vestibulum    urna.    Vivamus
tincidunt  suscipit  enim, nec
ultrices   nisi  volutpat  ac.
Maecenas   sit   amet  lacinia
arcu,  non dictum justo. Donec
sed  quam  vel  risus faucibus
euismod.  Suspendisse  rhoncus
rhoncus  felis  at  fermentum.
Donec lorem magna, ultricies a
nunc    sit    amet,   blandit
fringilla  nunc. In vestibulum
velit    ac    felis   rhoncus
pellentesque. Mauris at tellus
enim.  Aliquam eleifend tempus
dapibus. Pellentesque commodo,
nisi    sit   amet   hendrerit
fringilla,   ante  odio  porta
lacus,   ut   elementum  justo
nulla et dolor."
lines = justify2(s, 30)
puts lines