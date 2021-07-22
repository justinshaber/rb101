flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# flintstones.each do |name|
#   name.slice!(3..)
# end

flintstones.map! { |name| name[0,3] } 

p flintstones