famous_words = "seven years ago..."
# puts "Four score and " << famous_words
# puts "Four score and #{famous_words}"
puts famous_words.object_id
famous_words.prepend("Four score and ")
puts famous_words.object_id