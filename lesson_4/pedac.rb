# PROBLEM:

# Given a string, write a method change_me which returns the same
# string but with all the words in it that are palindromes uppercased.

# change_me("We will meet at noon") == "We will meet at NOON"
# change_me("No palindromes here") == "No palindromes here"
# change_me("") == ""
# change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"

# INPUT: string
# OUTPUT: same string (not the same object)

=begin
# Explicit rules -
  write a method
  return same string but with all words that are palindromes uppercased
  'Dad' is not a palindrome, while 'dad' is

# Implicit rules -
  empty string should return empty string
  already uppercased words should remain uppercased
  only need to worry about non-string values

=end

# TEST CASES

# change_me("Mom") == "Mom"
# change_me("noontimedancingatnoon") == "noontimedancingatnoon"
# change_me("asbcbsa is awesome") == "ASBCBSA is awesome"
# change_me("The. Fox. Decided. To. CRY. sos.") == "The. Fox. Decided. To. CRY. SOS."
