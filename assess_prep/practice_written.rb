############################

a = [2]
puts a.object_id
b = [1, 3]
c = [a, b]
c[0][0] = 5
p c # =>  what will this print and why?
p a # =>  what object is a referencing? 
puts a.object_id # => Will this match the first object_id that is printed?

############################

# What will the pairs hash be after we run this code?

pairs = { "a" => 1, "b" => 2, "c" => 3 }

incremented_values = pairs.map do |k, v| 
  pairs[k] = v + 1 
end

p incremented_values # [2, 3, 4]
p pairs

############################
# What is the return value of reject in the following code? Why?

[1, 2, 3].reject do |num|
  puts num
end

############################
# What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

############################
# What is the return value of map in the following code? Why?

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

############################
# What is the return value of partition in the following code? Why?

[1, 2, 3].partition do |num|
  num.odd?
end

############################

# What is the return value of each_with_object in the following code? Why?

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

############################

# What is the return value of the following code? Why?

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

############################

# What does the code print out? Why?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

############################

# What is the output of the following code? Why?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

############################

# What is the result of the last line in the code below?

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting
puts greetings

############################