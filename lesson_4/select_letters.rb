odd, even = [1, 2, 3].partition do |num|
  num.odd?
end

p odd
p even