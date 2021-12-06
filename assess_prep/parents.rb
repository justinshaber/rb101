=begin
PROBLEM  
Return a new string with each uppercase letter followed by all occurences of it's lowercase. The
    uppercase letters should be ordered alphabetically.

Get all uppercase letters, alphabetize them, make them each a nested array.
Iterate through lowercase letters, add them to each nested array.
Join all
=end

def find_children(str)
  upper, lower = str.chars.sort.partition {|letter| letter == letter.upcase }

  results = upper.each do |upper_letter|
    lower.each do |lower_letter|
      if upper_letter.downcase.include?(lower_letter)
        upper_letter << lower_letter
      end
    end
  end

  results.join
end

p find_children("abBA") == "AaBb"
p find_children("AaaaaZazzz") == "AaaaaaZzzz"
p find_children("CbcBcbaA") == "AaBbbCcc"
p find_children("xXfuUuuF") == "FfUuuuXx"
p find_children("") == ""