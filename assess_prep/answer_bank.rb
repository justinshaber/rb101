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
  # a = 4
  # b = 2

  # loop do  
  #   c = 3
  #   a = c
  #   break
  # end

  # puts a
  # puts b

=begin
  When we call the puts method on line 10, 3 is passed as an argument and output to the screen.
    When we call the puts method on line 11, 2 is passed as an argument and output to the screen. Both invocations
    return `nil`.

  The value of local variable `b` remains 2, and is also printed to the screen. `Loop do..end` creates a block with an
    inner scope. Inner scope can access variables initialized in an outer scope, but not vice versa. As a result,
    local variable `a` is allowed to be reassigned  within the block on line 6 because it was initialized in an
    outer scope on line 1.
=end


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

  # a = 'Bob'

  # 5.times do |x|
  #   a = 'Bill'
  # end

  # p a

=begin 
  `5.times do ... end` creates a block with an inner scope. Inner scope can access variables initialized in an outer scope,
    but not vice versa. As a result, the value of `a` is allowed to be reassigned because it was initialized in an outer
    scope. At the end of the program local variable `a` points to new string `'Bill'`, and is printed to the console.

  The value of `a` is 3. This is because `a` is available to the inner scope created by `5.times do ... end`,
    which allowed the code to reassign the value of 'a'. 
=end

  # a = 'Bob'

  # def test_times(x)
  #   a = 'Bill'
  # end

  # p a

=begin
  The `test_times` method definition creates a self-contained scope. You can't refer to or modify any variables
    that aren't initialized within the method. As a result, local variable `a` is not allowed to be reassigned
    within the method body, so at the end of the program, `a` still points to string `Bob`.

  The local variable `a` points to string `'Bob'`. This is because `a`, initialized outside the method definition on line 1,
    is not available within the self-contained scope created by the method definition, and cannot be accessed or modified.
=end


###MUTATING v NON_MUTATING###
  # a = [1, 2, 3]
  
  # def mutate(array)
  #   array.pop
  # end

  # p "Before #{a}"
  # mutate(a)
  # p "After #{a}"

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
  { a: "ant", b: "bear", c: "cat" }.all? do |key, value|
    value.length >= 3
  end

=begin
  The code snippet returns boolean `true`.
  the `all` method is being invoked on the hash `{ a: "ant", b: "bear", c: "cat" }`. `all` iterates
    through each element of the hash and returns a boolean true if every passed block evaluates to
    true. If any block does not evaluate as true, the method will not iterate further and return boolean false.

  `value.length >= 3` implicitly returns a boolean because the the evaluated value of the last line in a block is always returned. 

=end

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