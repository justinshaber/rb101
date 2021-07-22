statement = "supercalifragilisticexpialidocious"
puts statement.size

arr = statement.chars
hash = {}

loop do
  current_char = arr[0]
  hash[current_char] = arr.count(current_char)

  arr.delete(current_char)

  break if arr.empty?
end

p hash
p hash.values.sum
