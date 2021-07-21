def is_an_ip_number?(word)
  word.to_i >= 0 && word.to_i <= 255
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    is_an_ip_number?(word) ? next : false
    # return false unless is_an_ip_number?(word)
  end

  true
end

puts dot_separated_ip_address?("10.4.5.11")
puts dot_separated_ip_address?("4.5.5")
puts dot_separated_ip_address?("1.2.3.4.5")
