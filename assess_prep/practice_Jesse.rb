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
# ------------------------------------
# ------------------------------------
# ------------------------------------
# ------------------------------------
# a = 1
# b = 2

# if a
#   puts "Hallo!"
# elsif b
#   puts "Goodbye!"
# else
#   puts "No greeting for you!"
# end

# What does this code output? Why?

# The code will output the string `Hallo!` to the console every time. Ruby evaluates every value as true, excpet for `false` and `nil`.
# Because local variable `a` is initialized to integer 1 on line 50, and Ruby will evaluate integers as true, the conditional on line 53,
# will always evaluate as true, executing the code on like 54. On line 54, we invoke the puts method, passing `"Hallo"` as an argument
# which outputs `Hallo` to the console and returns `nil`.

# ------------------------------------
# def greeting(name)
#   "Hello, #{name}!"
# end

# greeting('Bobby')

# # what is the item on lines 1-3? What about line 5? What are they called and how are they different?
=begin
  On lines 1-3, we have a method definition for a method named `greeting` with one paramenter, `name`. On line 5, we have a method invocation, with a string
  being passed as an argument. Method defintions set their own scope for local variables in terms of parameters and interaction with blocks. Method invocations
  use the scope set by method definition. In this example, we see the string `"Bobby"` is able to be used within the method defintion because it is passed in as
  an argunment. Within the method definition, `name` references the string `"Bobby"` and can be used and modified.
 
=end
# # ------------------------------------
# name = 'Susie'

# def greeting
#   puts "Hello #{name}!"
# end

# greeting
# puts greeting
# # what do the last two lines output? Why?

=begin
  When we run this code, a `NameError` is thrown on line 90. The program stops, and line 94 is never run. This is because the variable `name` is undefined
  within the method definition. Method definitions set their own scope, which means the `greeting` method defintion cannot access or modify a variable initialized
  within an outer scope, such as `name`, unless it is passed in as an argument through method invocation, and defined within the method defintion as a parameter.
=end

# # ------------------------------------
# def greeting(word)
#   word << '!!!'
# end

# name = 'Jim'
# greeting(name)
# p name
# # what is name? Explain why

=begin
  At the end of the code, on line 110, local variable `name` references the mutated string `Jim!!!`. We invoke the `greeting` method on line 109, passing in local
  variable `name`, which references string `'Jim'`. Within the `greeting` method definition on lines 104-106, local variable `word` also references the string `'Jim'`.
  On line 105, the `<<` shovel method invocation is destructive, therefore when we append `"!!!"` to the object referenced by `word`, the change is seen by all other
  variables which point to the same object. Therefore the object referenced by local variable `name` is mutated from `Jim` to `Jim!!!` because of the method invocation.
=end

# # ------------------------------------

# def plus(x, y)
#   x = x + y
# end
# a = 3
# b = plus(a, 2)
# puts a
# puts b

# # What do the last two lines of code output? Why?

=begin
  When we invoke the `puts` method on lines 127 and 128, passing in local variables `a` and `b` respectively, 3 and 5, are output to the console, respectively.
  Each `puts` method invocation returns `nil`.

  When we invoke the `plus` method on line 126, we pass in two arguments, one of which is local variable `a` which is initialzied to an integer 3. Because integers
  in Ruby are immutable, we know that the integer that `a` references will remain unchanged by code within the method defintion. Therefore, on line 127, we know that
  local variable `a` will continue to reference integer 3.

  On line 126, local variable `b` is initialized to the return value of the `plus` method invocation with two arguments, the integer 3 referenced by `a` and the integer 2.
  The last line of the method definition body `x = x + y` will evaluate to 5, and the method will implicitly return that integer value because it is the last line in the method defintion.
  Therefore local variable `b` is initialized to 5 on line 126.

=end

# # ------------------------------------
# p ['arc', 'bat', 'cape', 'ants', 'cap'].sort

=begin
  On ine 147, We invoke the `String#sort` method on an array containing five string elements. The sort array uses the `<=>` spaceship operator to sort the strings.
  `<=>` will compare two elements and return -1, 0, or 1 depending on if the element on the left is less than, equal to, or great than the element on the right.
  When sorting strings, the sort method will iterate character by character comparing the ASCII values of each. If all characters are the same, `sort` compares the length
  of the strings. Therefore, in this code, the `sort` method will return a new array ['ants', 'arc', 'bat', 'cap', 'cape'].
=end

# # ------------------------------------
# def method()
#   if false
#     1
#   else
#     number = 2
#   end

#   number
# end

# puts method

=begin
  When we invoke the `puts` method on line 167, passing in the return of the `method` method invocation, 2 is output to the screen and `nil` is returned.
  The conditional on line `158` will never be true, and therefore the code within the else on line 161 will always execute. Line 161, initializes local variable `number`
  to the integer 2, which is then returned by the method.
=end

# # ------------------------------------
# # What is the block's return value in the following code? How is it determined?
# # Also, what is the return value of any? in this code and what does it output?

# [1, 2, 3].any? do |num|
#   puts num
#   num.odd?
# end

=begin
  The `do..end` will always implicitly return the last evaluated line, in this case, `num.odd?`. Invoking the `Integer#.odd?` method returns a boolean `true` or `false`
  depending on whether the integer it is called on is odd or even, respectively. Thereforefore the block will return true on the first iteration when `num` is 1.

  We invoke the `any?` method on an array object with three integer elements, passing in a `do..end` block with one parameter `num`. Invoking the `any?` method will
  begin iterating over the elements in the collection it is called on, passing each element to the block as an argument in turn, and running the block once. The `any?`
  method will stop iterating, and return boolean `true` if if the last line in the block evaluates as true. The `any` method invocation will return boolean `false` if all
  iterations block's return values are `false` or `nil`. Because the block will return true on the first iteration when `num` is 1, the `any` method returns true.

  Additionally, on line 170, we invoke the  `puts` method, passing in the integer 1 referenced by local variable `num` which outputs 1 to the console.
=end

# # ------------------------------------