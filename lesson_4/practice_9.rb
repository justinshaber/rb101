def titleize(str)
  str.split.map! { |word| word.capitalize }.join(" ")
end

puts titleize("the flintstones rock")
puts titleize("previously we can use some")
puts titleize("In both cases we see that iterators DO NOT work")