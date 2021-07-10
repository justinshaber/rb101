# change name when you finalize!
require 'yaml'
MESSAGE = YAML.load_file('rps_messages.yml')

VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  l: 'lizard',
  sp: 'spock'
}

WIN_OPTIONS = {
  r: ['l', 's'], 
  p: ['r', 'sp'],
  s: ['l', 'p'],
  l: ['p', 'sp'],
  sp: ['r', 's']
}

def prompt(message)
  puts "=> #{MESSAGE[message]}"
end

def display_welcome(iteration)
  if iteration == 0
    puts format(MESSAGE['welcome'], options: VALID_CHOICES.values.join(', '))
  end

  puts format(MESSAGE['game_prompt'], options: VALID_CHOICES.values.join(', '))
end

def valid_choice?(choice)
  VALID_CHOICES.key?(choice.to_sym) ||
    VALID_CHOICES.value?(choice)
end

def get_choice(iteration)
  choice = ''
  loop do
    display_welcome(iteration)

    choice = gets.chomp.downcase

    break if valid_choice?(choice)
    prompt('invalid_choice')
  end
  if choice.length <= 2
    VALID_CHOICES[choice.to_sym]
  else
    choice
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

def display_game_result(player, computer)
  if who_wins?(player, computer)
    prompt('win')
  elsif who_wins?(computer, player)
    prompt('lose')
  else
    prompt('tie')
  end
  reset_display
end

def reset_display
  sleep 1.75
  system "clear"
end

def update_score(p1, p2)
  who_wins?(p1, p2) ? 1 : 0
end

def display_final_result(p1_final, p2_final)
  if p1_final > p2_final
    prompt('final_winner')
  else
    prompt('final_loser')
  end
end

def play_again?
  prompt('ask_play_again')
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

loop do
  p1_score = 0
  p2_score = 0
  game_iteration = 0

  loop do
    user_choice = get_choice(game_iteration)
    comp_choice = VALID_CHOICES.values.sample

    puts "You chose #{user_choice}: Computer chose #{comp_choice}"
    display_game_result(user_choice, comp_choice)

    p1_score += update_score(user_choice, comp_choice)
    p2_score += update_score(comp_choice, user_choice)
    game_iteration += 1

    puts "Your score: #{p1_score}"
    puts "Computer score: #{p2_score}"
    if p1_score == 3 || p2_score == 3
      display_final_result(p1_score, p2_score)
      break
    end
  end
  break unless play_again?
end

prompt('goodbye')
