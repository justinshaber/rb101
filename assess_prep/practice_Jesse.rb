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

a = 1
b = 2

if a
  puts "Hallo!"
elsif b
  puts "Goodbye!"
else
  puts "No greeting for you!"
end

# What does this code output? Why?

def greeting(name)
  "Hello, #{name}!" # returns a string (making use of string interpolation)
end

greeting('Bobby')

# what is the item on lines 1-3? What about line 5? What are they called and how are they different?

name = 'Susie'

def greeting
  puts "Hello #{name}!"
end

greeting
puts greeting
# what do the last two lines output? Why?

def greeting(word)
  word << '!!!'
end

name = 'Jim'
greeting(name)
p name
# what is name? Explain why

