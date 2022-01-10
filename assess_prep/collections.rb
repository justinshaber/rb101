# p (['ant', 'bat', 'caterpillar'].count do |str|
#   str.length < 4
# end)

# p ([1, 2, 3].reject do |num|
#   puts num
# end)

# p hash = { a: 'ant', b: 'bear' }
# p hash.shift
# p hash

# array = ['ant', 'bear', 'caterpillar']

# p array.pop(2)
# p array

# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.shift(1)
# end
# p numbers
# #----First iteration
# [1, 2, 3, 4] # 1 is the first element
# # 1 is printed
# [2, 3, 4] # first element is removed
# #-----Second iteration
# [2, 3, 4] # 3 is the second element
# # 3 is printed
# [3, 4] # first element is removed
# #-----
# [3, 4] # No third iteration, because no third element.
