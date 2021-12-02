=begin

Always aim to answer:
  What does the following code output and return?
  Why?
  What concept does it demonstrate?

###PUTS v RETURN###
  return - every method returns the evaluated result of the last line that is executed
            unless a specific `return` is come before it.
         - when `return` is placed within a method, it just returns the evaluated result of the following code
              without executing any further lines.           
  p - prints out the value returned by the following code/method
  puts - displays the results of evaluating Ruby code with a new line at the end, and returns nil

###VARIABLES AS POINTERS###
###VARIABLE SCOPE###
  Inner scope can access variables initialized in an outer scope, but not vice versa.
  variable scope is defined by a *method DEFINITION* or a block.
  method have self-contained scope - A method definition has no notion of "outer" or "inner" scope--its scope is self-contained.
    Methods can only refer to or modify variables that are initialized within the method or that are defined as parameters.
    Variables initialized within the method are not available outside the method's body.
  block - piece of code that follows a *method INVOCATION*, delimited by `{}` or `do/end`
    `do/end` and `{}` are the blocks! It becomes a block following method invocation.

###MUTATING v NON_MUTATING###
  `a << "str"` - mutates the caller and modifies the existing [object] (str), which is also pointed to by variable 'b'
###COLLECTIONS###
  The block parameter is `|_|`, which represents each element as the `___` method iterates through the collection.
###TRUTHINESS###
###METHOD DEFINITION v INVOKE###
  The method has a parameter `_` which allows the method to access the object `_` since it is passed in as 
    an argument at method invocation in the form of the local variable `_`.
  Method definition is when we define a Ruby method using `def` keyword.
###IMPLICIT RETURN VALUE###
  "The evaluated result of the last line of the method."
###ARRAY.SORT###
=end



