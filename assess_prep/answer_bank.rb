# What does the following code output and return?
# Why?
# What concept does it demonstrate?

###PUTS v RETURN###
###VARIABLES AS POINTERS###
  # a = "hi there"
  # b = a
  # a = "not here"

=begin
  On line 1 variable `a` is initialized to point the string `hi there`. On line 2, variable 'b'
  is initialized to point to the same object pointed to by variable 'a'. On line 3 variable 'a' is
  reassigned to point to new string `not here`. Because variables are pointers to physical spaces in memory,
  variable 'b' continues to point to `hi there`.
=end

  # a = "hi there"
  # b = a
  # a << ", Bob"

=begin
  On line 1, variable `a` is initialized to point to string `hi there`. On line 2, variable `b` is initialized
  to point to the same object. `a << ", Bob"` mutated the caller and modified the exiting string, which is also 
  pointed to by variable `b`. At the end of the program variables `a` and `b` point to the original mutated string object
  "hi there, Bob".

  
=end

###VARIABLE SCOPE###
  # def some_method(number)
  #   number = 7
  # end

  # a = 5
  # some_method(a)
  # puts a

=begin
  On line 6, variable `a` is passed into `some_method`. In `some_method`, local variable `number` is initialized to point
  to the same object as variable 'a'. Number is then reassigned to the value "7". The value of `a` remains unchanged because 
  `number` is scoped at the method definitiion level.
=end

###MUTATING v NON_MUTATING###
  a = [1, 2, 3]
  
  def mutate(array)
    array.pop
  end

  p "Before #{a}"
  mutate(a)
  p "After #{a}"

=begin
  The program permanently modified the array that local variable `a` references by passing it to the mutate method, even though
  `a` is outside the method definition's scope. This is because the `pop` method mutates the caller (`array`). `a` still points
  to the same array, but the number of elements had changed.

  On line 8, variable 'a' is passed into `mutate`. In `mutate`, local variable 'array' is initialized to point to the same
  object as variable `a`--array object `[1, 2, 3]`. Because pop is a destructive method, it mutates the caller, permanently
  changing the original array object to `[1, 2]`.
=end

  # def testing(b)
  #   b.map {|letter| "I like the letter: #{letter}"}
  # end

  # a = ['a', 'b', 'c']
  # testing(a)
  
=begin
  On line 5, variable `a` is initialized to point to array `['a', 'b', 'c']`. On line 1,
  local variable `b` is initialized to point to the same array object. Inside `testing`, we did not
  perform any destructive actions, leaving `a` unchanged at the end of the program.
=end



###COLLECTIONS###
###TRUTHINESS###
###METHOD DEFINITION v INVOKE###
###IMPLICIT RETURN VALUE###
  # def add_three(number)
  #   return number + 3
  #   number + 4
  # end

  # returned_value = add_three(4)
  # puts returned_value

=begin
  On line 20, the integer `7` is output to the screen because `return_value` is initialized on line 19 to
  point to the return value of `add_three(4)`. Because every method returns the evaluated result of the last 
  line that is executed, `add_three` will return will return an integer that is the passed argument + 3.
=end

###ARRAY.SORT###