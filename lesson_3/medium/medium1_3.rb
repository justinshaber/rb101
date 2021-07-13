def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors # the last line of the method is returned.
end

p factors(40)
# number % divisor == 0 uses 'remainder' to see if
# divisor is a factor of number