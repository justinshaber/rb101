player_score = 0
computer_score = 0

def comp_winner?
  winner
end


if who_wins?(player, computer)
  prompt('win')
  player_score += 1
elsif who_wins?(computer, player)
  prompt('lose')
  computer_score += 1
else
  prompt('tie')
end