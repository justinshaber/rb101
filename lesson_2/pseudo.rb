# a method that return sum of two integers
=begin
  DEFINE add_ints with two parameters
    a + b
  end
=end

# a method that takes an array of strings
# returns a string that is all those strings concatenated together

=begin

  define method with one parameter
    SET final_string
    iterate over array
      add each string to final_string
    return final_string
  end

=end

def string_maker(array)
  final_string = ''
  array.each {|word| final_string += word }
  final_string
end

fox_trot = %w(The quick brown fox jumps over the lazy dog)
puts string_maker(fox_trot)

#method that takes array of ints
#returns new array with every other element

=begin
  START
  DEFINE a method with one param
    SET iterator
    iterate over the array
      adds every other value to a new array
      
      Iterate += 2

    return new array

  test cases
  END
=end