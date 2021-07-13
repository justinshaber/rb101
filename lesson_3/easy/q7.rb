#flintstones = ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
#flintstones.flatten!
#p flintstones

flintstones = { "Fred" => 0, 
                    "Wilma" => 1, 
                    "Barney" => 2, 
                    "Betty" => 3, 
                    "BamBam" => 4, 
                    "Pebbles" => 5 }

#flintstones.select! { |_, value| value == 2 }
#flintstones = flintstones.to_a.flatten!
p flintstones.assoc("Barney")
p flintstones

