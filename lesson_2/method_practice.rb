=begin
puts "hello world"
answer = gets.chomp
system("clear")
puts answer
=end

WIN_OPTIONS = {
  r: ['l', 's'], 
  p: ['r', 'sp'],
  s: ['l', 'p'],
  l: ['p', 'sp'],
  sp: ['r', 's']
}

puts WIN_OPTIONS[:r].include?('sp')