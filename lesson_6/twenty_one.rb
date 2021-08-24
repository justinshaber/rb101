require 'pry-byebug'
require 'yaml'
MESSAGE = YAML.load_file('twenty_one_messages.yml')

SUITS = %w(c d h s)
NUM_CARDS = ("2".."10").to_a
FACE_CARDS = %w(J Q K A)
ALL_CARDS = NUM_CARDS + FACE_CARDS

def initialize_players
  dealer = { cards: [], total: [], hole_card: false, display_total: false }
  player = { cards: [], total: [], bank: 100, bet: nil }

  [dealer, player]
end

def prompt(message, options = '')
  puts format("=> #{MESSAGE[message]}", options: options)
end

def initialize_deck
  new_deck = []
  SUITS.each do |suit|
    ALL_CARDS.each do |card|
      new_deck << card + suit
    end
  end

  new_deck
end

def shuffle_deck(deck)
  deck.shuffle!
end

def first_deal(deck, dealer_info, player_info)
  2.times do
    deal_a_card(deck, player_info)
    deal_a_card(deck, dealer_info) # only show dealers second card
  end
end

def deal_a_card(deck, hash_info)
  hash_info[:cards] << deck.shift
end

def display_table(deal_hash, player_hash)
  system 'clear'
  puts "     Dealer"
  puts "    #{show_dealer_cards(deal_hash)} ==> #{show_dealer_total(deal_hash)}"
  puts ""
  puts "    You bet: $#{player_hash[:bet]}"
  puts ""
  puts "    #{display_cards(player_hash)} ==> #{display_total(player_hash)}"
  puts "     Player"
  puts "      $#{player_hash[:bank]}"
  puts ""
end

def display_cards(player_info)
  player_info[:cards].map { |card| "|#{card}|" }.join(" ")
end

def show_dealer_cards(dealer_info)
  if dealer_info[:hole_card]
    display_cards(dealer_info)
  else
    "| | |#{dealer_info[:cards][1]}|"
  end
end

def display_total(hash_info)
  return "Blackjack!" if hash_info[:cards].size == 2 && blackjack?(hash_info)

  if soft_high_total?(hash_info)
    "#{hash_info[:total][0]} or #{hash_info[:total][1]}"
  else
    hash_info[:total][0]
  end
end

def show_dealer_total(dealer_info)
  dealer_info[:display_total] ? display_total(dealer_info) : "?"
end

def reveal_dealer_info(dealer_info)
  dealer_info[:hole_card] = true
  dealer_info[:display_total] = true
end

def calculate_total(hash_info)
  non_ace_cards, aces = hash_info[:cards].partition { |card| card[0] != "A" }
  non_ace_values = []

  non_ace_cards.each do |card|
    non_ace_values << (NUM_CARDS.include?(card[0]) ? card[0].to_i : 10)
  end

  non_ace_total = non_ace_values.sum

  return add_aces(non_ace_total, 1) if aces.size == 1
  return add_aces(non_ace_total, 2) if aces.size == 2

  [non_ace_total]
end

def add_aces(non_ace_total, aces)
  low_total = non_ace_total + aces
  high_total = non_ace_total + 10 + aces

  totals = []
  totals << low_total if low_total
  totals << high_total if high_total <= 21

  totals
end

def update_total(hash_info)
  hash_info[:total] = calculate_total(hash_info)
end

def soft_high_total?(hash_info)
  hash_info[:total].size == 2
end

def hard_total(hash_info)
  hash_info[:total][0]
end

def soft_total(hash_info)
  hash_info[:total][1]
end

def remove_low_total(hash_info)
  hash_info[:total].delete(hash_info[:total].min)
end

def blackjack?(hash_info)
  hash_info[:total].any? { |total| total == 21 }
end

def hit_or_stay?
  loop do
    prompt("hit_or_stay?")
    answer = gets.chomp.downcase

    return answer if answer == "h" || answer == "s"
    prompt("invalid_response")
  end
end

def hit(deck, hash_info)
  deal_a_card(deck, hash_info)
  update_total(hash_info)
end

def players_turn(deck, dealer_info, player_info)
  loop do
    break if blackjack?(player_info)

    choice = hit_or_stay?
    if choice == 'h'
      hit(deck, player_info)
      display_table(dealer_info, player_info)
    end
    break if choice == 's' || bust?(player_info)
  end
end

def dealers_turn(deck, dealer_info)
  loop do
    break if blackjack?(dealer_info)
    break if hard_total(dealer_info) >= 17
    break if soft_high_total?(dealer_info) && soft_total(dealer_info) >= 18

    hit(deck, dealer_info)
  end
end

def bust?(hash_info)
  hash_info[:total].all? { |total| total > 21 }
end

def compare_cards(dealer_info, player_info)
  dealer_high_total = dealer_info[:total].select { |x| x < 22 }.max
  player_high_total = player_info[:total].select { |x| x < 22 }.max

  return "push" if dealer_high_total == player_high_total
  dealer_high_total < player_high_total ? "win" : "lose"
end

def play_again?
  loop do
    prompt('cash_or_bet')
    answer = gets.chomp

    return true if answer.downcase == '$'
    return false if answer.downcase == 'c'

    prompt('invalid_choice', "[c] or [$]")
  end
end

def display_game_over(dealer_info, player_info, message)
  display_table(dealer_info, player_info)
  prompt(message)
end

def update_final_totals(dealer_info, player_info)
  reveal_dealer_info(dealer_info)
  remove_low_total(dealer_info) if soft_high_total?(dealer_info)
  remove_low_total(player_info) if soft_high_total?(player_info)
end

def bet(bank)
  prompt('bet', bank)
  answer = nil

  loop do
    answer = gets.to_i
    break if answer.to_s.to_i == answer
    prompt('invalid_choice')
  end

  answer
end

loop do
  dealer, player = initialize_players
  deck = shuffle_deck(initialize_deck)

  prompt('welcome')
  player[:bet] = bet(player[:bank])
  player[:bank] -= player[:bet]
  first_deal(deck, dealer, player)

  update_total(dealer)
  update_total(player)

  display_table(dealer, player)

  if blackjack?(dealer)
    update_final_totals(dealer, player)
    display_game_over(dealer, player, "dealer_blackjack")
    play_again? ? next : break
  end

  players_turn(deck, dealer, player)

  if bust?(player)
    update_final_totals(dealer, player)
    display_game_over(dealer, player, "player_busted")
    play_again? ? next : break
  end

  dealers_turn(deck, dealer)

  if bust?(dealer)
    update_final_totals(dealer, player)
    display_game_over(dealer, player, "dealer_busted")
    play_again? ? next : break
  end

  update_final_totals(dealer, player)
  display_game_over(dealer, player, compare_cards(dealer, player))
  break unless play_again?
end

puts "Thanks for playing"
