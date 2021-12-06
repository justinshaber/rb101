# ------------------------------------
# [1, 2, 3].all? do |num|
#   num > 2
# end
# ------------------------------------
# arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# new_array = arr.select do |n| 
#   n + 1
#   puts n
# end
# p new_array
# ------------------------------------
# def add_name(arr, name)
#   arr = arr << name
# end

# names = ['bob', 'kim']
# add_name(names, 'jim')
# puts names
# ------------------------------------
# arr1 = ["a", "b", "c"]
# arr2 = arr1.dup
# arr2.map! do |char|
#   char.upcase
# end

# arr1
# arr2 
# ------------------------------------
# def a_method(str)
#   str += '!!!'
#   str.downcase!
# end

# test_str = 'Something'
# a_method(test_str)

# puts test_str
# ------------------------------------
# p ['arc', 'bat', 'cape', 'ants', 'cap'].sort
# ------------------------------------

=begin
start with sort not with p
good - how sort works with strings

=end