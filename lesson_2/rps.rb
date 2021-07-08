#change name when you finalize!

VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def valid_choice?(choice)
  VALID_CHOICES.include?(choice)
end

def winner(player, computer)
  (player == 'rock' && computer == 'scissors') ||
    (player == 'paper' && computer == 'rock') ||
    (player == 'scissors' && computer == 'paper')
end

def loser(player, computer)
  (player == 'scissors' && computer == 'rock') ||
    (player == 'rock' && computer == 'paper') ||
    (player == 'paper' && computer == 'scissors')
end


def display_result(player, computer)
  if winner(player, computer)
    prompt("You won!")
  elsif loser(player, computer)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def get_choice
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    break if valid_choice?(choice)
    prompt("That's not a valid choice.")
  end
  choice
end

def play_again?
  prompt("Do you want to play again?")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end


loop do
  choice = get_choice

  comp_choice = VALID_CHOICES.sample

  puts "You chose #{choice}: Computer chose #{comp_choice}"

  display_result(choice, comp_choice)

  break unless play_again?
end

prompt("Thanks for playing! Adios!")

