# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.shift(1)
# end

# numbers_2 = [1, 2, 3, 4]
# numbers_2.each do |number|
#   p number
#   numbers_2.pop(1)
# end

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
numbers.each_with_index do |number, index|
  p "#{index}  #{numbers.inspect}  #{number}"
  numbers.shift(1)
end