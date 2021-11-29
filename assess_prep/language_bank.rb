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
  method have self-contained scope - you can't refer to or modify any variables that aren't initialized within
    the method. Variables initialized within the method are not available outside the method's body.
  block - piece of code that follows a *method INVOCATION*, delimited by `{}` or `do/end`
    `do/end` and `{}` are the blocks! It becomes a block following method invocation.

###MUTATING v NON_MUTATING###
  `a << "str"` - mutates the caller and modifies the existing [object] (str), which is also pointed to by variable 'b'
###COLLECTIONS###
###TRUTHINESS###
###METHOD DEFINITION v INVOKE###
###IMPLICIT RETURN VALUE###
  "The evaluated result of the last line of the method."
###ARRAY.SORT###
=end



