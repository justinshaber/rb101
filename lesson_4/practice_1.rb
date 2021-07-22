flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# hash = flintstones.to_h {|item| [item, (flintstones.index(item) + 1)]}

hash = {}
flintstones.each_with_index { |name, index| hash[name] = index }

p hash