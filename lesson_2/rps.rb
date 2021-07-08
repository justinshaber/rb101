# change name when you finalize!
require 'pry'
require 'yaml'
MESSAGE = YAML.load_file('rps_messages.yml')

VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  l: 'lizard',
  sp: 'spock'
}
player_score = 0
computer_score = 0

def prompt(message)
  puts "=> #{MESSAGE[message]}"
end

def valid_choice?(choice)
  VALID_CHOICES.has_key?(choice.to_sym) ||
    VALID_CHOICES.has_value?(choice)
end

def get_choice
  choice = ''
  loop do
    puts format(MESSAGE['welcome'], options: VALID_CHOICES.values.join(', '))
    choice = gets.chomp.downcase

    break if valid_choice?(choice)
    prompt('invalid_choice')
  end
  if choice.length <= 2
    return VALID_CHOICES[choice.to_sym]
  else
    return choice
  end
end

def who_wins?(player1, player2)
  (player1 == 'rock' && player2 == 'scissors') ||
    (player1 == 'paper' && player2 == 'rock') ||
    (player1 == 'scissors' && player2 == 'paper') ||
    (player1 == 'rock' && player2 == 'lizard') ||
    (player1 == 'lizard' && player2 == 'spock') ||
    (player1 == 'spock' && player2 == 'scissors') ||
    (player1 == 'scissors' && player2 == 'lizard') ||
    (player1 == 'lizard' && player2 == 'paper') ||
    (player1 == 'paper' && player2 == 'spock') ||
    (player1 == 'spock' && player2 == 'rock')
end

def display_result(player, computer)
  if who_wins?(player, computer)
    prompt('win')
    player_scores
  elsif who_wins?(computer, player)
    prompt('lose')
    computer_scores
  else
    prompt('tie')
  end
end

def play_again?
  prompt('ask_play_again')
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

loop do
  loop do
      user_choice = get_choice
      comp_choice = VALID_CHOICES.values.sample
      puts "You chose #{user_choice}: Computer chose #{comp_choice}"
      
      display_result(user_choice, comp_choice)    
  end

  break unless play_again?
end
prompt('goodbye')
