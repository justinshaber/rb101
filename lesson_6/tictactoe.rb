require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals

score = { Player: 0, Computer: 0, Game: 0 }
first_to_go = ''
current_player = ''

def prompt(str)
  puts "=> #{str}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, score)
  system 'clear'
  puts " You're #{PLAYER_MARKER} | Computer is #{COMPUTER_MARKER}"
  puts "Player: #{score[:Player]} | Computer: #{score[:Computer]} | Games: #{score[:Game]}"
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

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def set_first_to_go
  first = nil
  loop do
    prompt ("Who should go first?\nPress '1' - You go first\nPress '2' - Computer goes first\nPress '3' - Computer chooses who goes first")
    first = gets.chomp.to_i

    break if (1..3).include?(first)
    prompt "Invalid choice"
  end
  first
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

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1

     desired_position = brd.values_at(*line).index(' ')
     return line[desired_position]
  else
    nil
  end
end

def place_piece!(board, current)
  current == 'Player' ? player_places_piece!(board) : computer_places_piece!(board)
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Invalid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square
    square = 5 if empty_squares(brd).include?(5)
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_game_winner(brd)
end

def detect_game_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_match_winner(score)
  score[:Player] == 3 ? 'Player' : 'Computer'
end

loop do
  board = initialize_board
  
  if score[:Game] == 0
    first_to_go = set_first_to_go
  end

  first_to_go == 1 ? current_player = 'Player' : current_player = 'Computer'

  loop do
    display_board(board, score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  score[:Game] += 1

  if someone_won?(board)
    score[detect_game_winner(board).to_sym] += 1
    display_board(board, score)
    prompt "#{detect_game_winner(board)} won the game!"
  else
    display_board(board, score)
    prompt "It's a tie"
  end

  if score[:Player] == 3 || score[:Computer] == 3
    prompt "#{detect_match_winner(score)} won the match!"
    prompt "Play again? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
    score.each {|key, _| score[key] = 0} 
  end
end

prompt "Thanks for playing Tic Tac Toe! Goodbye."
