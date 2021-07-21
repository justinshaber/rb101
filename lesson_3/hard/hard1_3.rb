def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

def mess_with_vars_2(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one" #id - 49
two = "two" 
three = "three"

#mess_with_vars(one, two, three)
mess_with_vars_2(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"