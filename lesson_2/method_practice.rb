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

VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  l: 'lizard',
  sp: 'spock'
}

scores = { user: 0, comp: 0, game: 0 }

def update_score(hash)
  puts hash[:user]
end

#p scores
update_score(scores)
p scores