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

WIN_OPTIONS = {
  rock: ['lizard', 'scissors'], 
  paper: ['rock', 'spock'],
  scissors: ['lizard', 'paper'],
  lizard: ['paper', 'spock'],
  spock: ['rock', 'scissors']
}

scores = { user: 0, comp: 0, game: 0 }

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

def display_game_result(player, computer)
  if WIN_OPTIONS[player.to_sym].include?(computer)
    prompt('win')
  elsif WIN_OPTIONS[computer.to_sym].include?(player)
    prompt('lose')
  else
    prompt('tie')
  end
  reset_display
end

def display_scoreboard(scores_hash)
  puts "Your score: #{scores_hash[:user]}"
  puts "Computer score: #{scores_hash[:comp]}"
end

def reset_display
  sleep 1.75
  system "clear"
end

def update_score(p1, p2)
  WIN_OPTIONS[p1.to_sym].include?(p2) ? 1 : 0
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
  loop do
    user_choice = get_choice(scores[:game])
    comp_choice = VALID_CHOICES.values.sample

    puts "You chose #{user_choice}: Computer chose #{comp_choice}"
    display_game_result(user_choice, comp_choice)

    scores[:user] += update_score(user_choice, comp_choice)
    scores[:comp] += update_score(comp_choice, user_choice)
    scores[:game] = 1

    display_scoreboard(scores)

    if scores[:user] == 3 || scores[:comp] == 3
      display_final_result(scores[:user], scores[:comp])
      scores.transform_values! {|value| value = 0 }
      break
    end
  end
  break unless play_again?
end

prompt('goodbye')
