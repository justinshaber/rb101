# What does the following code output and return?
# Why?
# What concept does it demonstrate?

###PUTS v RETURN###
def count_sheep
  5.times do |sheep|
    puts sheep
    if sheep >= 2
      return
    end
  end
end

p count_sheep

=begin
  concepts - puts vs return, implicit return value (explicit return overrides implicit return)

  On lines 1-8 we have a method definition for the method `count_sheep`. Within that method we invoke the `Integer#times` method. The block parameter, `sheep`,
  will represent each integer in the count, and for each iteration we print the current integer value assigned to sheep to the screen. We also have an if statement
  that contains a `return` keyword.
  
  On line 10, when we invoke the count sheep method, we will output 0-2 from within the method, the method will return nil, and we then output the return value of the method.

  As we iterate through the block we will be counting from 0 to 1 to 2. On the third iteration, the condition ```sheep >= 2``` will evaluate as true and ruby will
    execute line 5. When we use `return` to explicitly return from a method, we return the value provided to that keyword `return`. In this code, there wasn’t any value provided.
    So we can expect the return value of the method to be `nil`. The `nil` is output to the console when it is returned from the `count_sheep` method call
    and passed to the `p` method.
   

  ----Transcribed from video walkthroughs.
  On line 7 we are invoking the count_sheep method, and printing the return value of the method to the console.
  We call `Integer#times` on 5, and ruby will iterate through the given block 5 times. The block parameter, `sheep`, will represent each integer in the count.
  The last line of the method is actually the invocation of the `Integer#times` method because the `do..end` block is an argument.
  "The evaluated result of the last line of the method"

    Within the block passed to times we have an if statement.
    When we invoke the count sheep method, we will output 0-2 from within the method, the method will return nil, and we then output the return value of the method.
    As we iterate through the block we will be counting from 0 to 1 to 2. On the third iteration, the condition ```sheep >= 2``` will evaluate as true and ruby will
    execute line 5. When we explicitly use the keyword return...
  ----



  On line 10, when `count_sheep` is called, ```0, 1, 2``` is output to the console. The return value of `count_sheep` is then passed to the
  `p` method call, which prints `nil` to the console.

  On line 2, the times method is passed the given `do..end` block once for each integer from 0 to the number it was called on, passing local variable `sheep` each time.

  On line 2, the times method is called on the integer 5, and passed the `do..end` block as an argument. A `times` loop is zero-based, 
  and therefore, on line 2, local variable `sheep` is initialized to integer 0 within the first iteration of the loop.
  On line 3, we are calling the puts method and pass it the current integer value assigned to sheep as an argument. On the first iteration,
  this invocation will output 0 and return nil.

  On line 4, ```sheep >= 2``` is evaluated using the current integer value assigned to sheep. Within the first iteration, the expression `0 >= 2`
  evaluates as `false` and the code does not enter into the `if` statement. The code then moves to the next iteration of the times loop,
  reassigning local variable `sheep` to integer 1. The code repeats the same process, outputting `1` to the console, not entering the `if`
  statement, and moving to the next iteration where local variable `sheep` is reassigned to integer `2`.

  When local variable `sheep` points to integer `2`, On line 3, we are calling the puts method and passing integer `2` as an argument. This
  invocation will output `"2"` and return nil. On line 4, the expression `2 >= 2` evaluates as true, and the `if` statement is entered.


=end

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

# a = 7
# array = [1, 2, 3]

# array.each do |element|
#   a = element
# end

# puts a

=begin
  The code will output `"3"` to the console and return `nil`.

  The each method calls the given block once for each element in the collection it is called on, passing that element as a parameter.
  On line 4, `each` method is called on `array` which was initialized on line 2 to point to `[1, 2, 3]`. Within each iteration, local
  variable `a` is reassigned to the current element. After the final iteration, local variable  `a` is reassigned to integer `3`, 
  the last element in `array`.

  On line 8, we are calling the puts method and pass it the integer `3`, which is pointed to by local variable `a`, as an argument.
  This invocation will output `3` and return `nil`.
=end

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
  # { a: "ant", b: "bear", c: "cat" }.all? do |key, value|
  #   value.length >= 3
  # end

=begin
    ++++
  The code snippet returns boolean `true`.
  the `all` method is being invoked on the hash `{ a: "ant", b: "bear", c: "cat" }`. `all` iterates
    through each element of the hash and returns a boolean true if every passed block evaluates to
    true. If any block does not evaluate as true, the method will not iterate further and return boolean false.

  `value.length >= 3` implicitly returns a boolean because the the evaluated value of the last line in a block is always returned. 

=end

###TRUTHINESS###

# number = 7

# if number
#   puts "My favorite number is #{number}."
# else
#   puts "I don't have a favorite number."
# end

=begin
  The program will output `"My favorite number is 7."` to the console and return `nil`.

  In Ruby, any value apart from 'nil' or false is considered truthy. Therefore, on line 3, local variable `number`, which points to integer `7`,
  evaluates to true. As a result, on line 4, we are calling the puts method and pass it the String "My favorite number is #{number}." as an argument. This
  invocation will output "My favorite number is 7." and return `nil`.
=end

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