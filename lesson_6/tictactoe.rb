require 'yaml'
MESSAGE = YAML.load_file('tictactoe_messages.yml')

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
WINNING_SCORE = 3

score = { Player: 0, Computer: 0 }
game = 0
first_to_go = ''
current_player = ''

def prompt(message, options = '')
  puts format("=> #{MESSAGE[message]}", options: options)
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, score)
  system 'clear'
  display_scoreboard(score)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def display_scoreboard(score)
  puts "You [#{PLAYER_MARKER}] | Computer [#{COMPUTER_MARKER}]"
  puts "  #{score[:Player]}     |      #{score[:Computer]}"
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def set_first_to_go
  first = nil
  loop do
    prompt('go_first')
    first = gets.chomp.to_i

    break if (1..3).include?(first)
    system 'clear'
    prompt('invalid_choice', joinor([1, 2, 3]))
  end

  first == 1 ? 'Player' : 'Computer'
end

def alternate_player(current)
  current == 'Player' ? 'Computer' : 'Player'
end

def joinor(arr, delimiter = ", ", and_or = "or")
  case arr.size
  when 0 then ''
  when 1 then arr.join
  when 2 then arr.join(" #{and_or} ")
  else
    str = arr.join(delimiter)
    str[-2] = " #{and_or} "
    str
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def find_desired_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1

    desired_position = brd.values_at(*line).index(' ')
    return line[desired_position]
  end
  nil
end

def place_piece!(board, current)
  current == 'Player' ? player_plays!(board) : computer_plays!(board)
end

def player_plays!(brd)
  square = ''
  loop do
    prompt('choose_square', joinor(empty_squares(brd)))
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt('invalid_choice', joinor(empty_squares(brd)))
  end
  brd[square] = PLAYER_MARKER
end

def play_third_square()

end

def computer_plays!(brd)
  square = nil
  WINNING_LINES.each do |line| # Computer will win if it can
    square = find_desired_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  if !square # Computer will block player from winning
    WINNING_LINES.each do |line|
      square = find_desired_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square # Computer will choose 5 if square is empty
    square = 5 if empty_squares(brd).include?(5)
  end

  if !square # Computer will choose a random square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!game_winner(brd)
end

def game_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def match_winner(score)
  score[:Player] == WINNING_SCORE ? 'Player' : 'Computer'
end

def enter_to_continue
  prompt('press_enter')
  STDIN.gets
end

def play_again?
  loop do
    prompt('ask_play_again')
    answer = gets.chomp

    return true if answer.downcase == 'y'
    return false if answer.downcase == 'n'

    prompt('invalid_choice', "[y] or [n]")
  end
end

loop do
  board = initialize_board

  if game == 0
    prompt('welcome', WINNING_SCORE)
    first_to_go = set_first_to_go
  end

  current_player = first_to_go

  loop do
    display_board(board, score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  game += 1
  score[game_winner(board).to_sym] += 1 if someone_won?(board)

  display_board(board, score)

  if someone_won?(board)
    prompt('game_winner', game_winner(board))
  else
    prompt('tie')
  end

  enter_to_continue unless score.values.include?(WINNING_SCORE)

  if score.values.include?(WINNING_SCORE)
    prompt('match_winner', match_winner(score))

    break unless play_again?
    score.each { |key, _| score[key] = 0 }
    game = 0
  end
end

prompt('goodbye')
