def multiply_numbers!(numbers, multiplier)
  new_numbers = []
  counter = 0
  
  loop do
    break if counter == numbers.size

    new_numbers << numbers[counter] * multiplier
    counter += 1
  end

  new_numbers
end

p my_numbers = [1, 4, 3, 7, 2, 6]
p multiply_numbers!(my_numbers, 2) # => [2, 8, 6, 14, 4, 12]
p multiply_numbers!(my_numbers, 3) # => [2, 8, 6, 14, 4, 12]
p multiply_numbers!(my_numbers, 4) # => [2, 8, 6, 14, 4, 12]
p my_numbers
