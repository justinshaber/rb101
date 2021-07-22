flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

be_names = []

flintstones.each_with_index do |name, index|
  be_names << index if name.start_with?("Be")
end

p be_names.first
# =============================
p flintstones.index {|name| name.start_with?("Be")}
p flintstones.index { |name| name[0, 2] == "Be" }