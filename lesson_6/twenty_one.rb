require 'pry-byebug'
require 'yaml'
MESSAGE = YAML.load_file('twenty_one_messages.yml')

SUITS = %w(c d h s)
NUM_CARDS = ("2".."10").to_a 
FACE_CARDS = %w(J Q K A)
ALL_CARDS = NUM_CARDS + FACE_CARDS

# dealer = { cards: [], total: [], hole_card: false, display_total: false }
# player = { cards: [], total: [] }

def initialize_players
  dealer = { cards: [], total: [], hole_card: false, display_total: false }
  player = { cards: [], total: [] }

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

def display_table(dealer_hash, player_hash)
  system 'clear'
  puts "     Dealer"
  puts "    #{display_dealer_cards(dealer_hash)} ==> #{display_dealer_total(dealer_hash)}"
  puts ""
  puts "     #{display_cards(player_hash)} ==> #{display_total(player_hash)}"
  puts "     Player"
end

def display_cards(player_info)
  player_info[:cards].map { |card| "|#{card}|" }.join(" ")
end

def display_dealer_cards(dealer_info)
  if dealer_info[:hole_card]
    display_cards(dealer_info)
  else
    "| | |#{dealer_info[:cards][1]}|"
  end
end

def display_total(hash_info)
  if hash_info[:total].size == 2
    return "#{hash_info[:total][0]} or #{hash_info[:total][1]}"
  else
    return hash_info[:total][0]
  end
end

def display_dealer_total(dealer_info)
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
    if NUM_CARDS.include?(card[0])
      non_ace_values << card[0].to_i
    else
      non_ace_values << 10
    end
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

  return totals
end

def has_low_high_totals?(hash_info)
  hash_info[:total].size == 2
end

def only_one_total?(hash_info)
  hash_info[:total].size == 1
end

def remove_low_total(hash_info)
  hash_info[:total].delete(hash_info[:total].min)
end

def blackjack?(hash_info)
  hash_info[:total].any? { |total| total == 21 }
end

def hit_or_stay?(deck, player_info)
  loop do
    prompt("hit_or_stay?")
    answer = gets.chomp.downcase

    return answer if answer == "h" || answer == "s"
    prompt("invalid_response")
  end
end

def hit(deck, hash_info)
  deal_a_card(deck, hash_info)
  hash_info[:total] = calculate_total(hash_info)
end

def players_turn(deck, dealer_info, player_info)
  loop do
    break if blackjack?(player_info)

    choice = hit_or_stay?(deck, player_info)
    if choice == 'h'
      hit(deck, player_info)
      display_table(dealer_info, player_info)
    end
    break if choice == 's' || bust?(player_info)
  end
end

def dealers_turn(deck, dealer_info, player_info)
  loop do
    if blackjack?(dealer_info)
      remove_low_total(dealer_info) if has_low_high_totals?(dealer_info)
      break
    end

    if only_one_total?(dealer_info)
      break if dealer_info[:total][0] >= 17
    end

    if has_low_high_totals?(dealer_info) 
      if dealer_info[:total].max >= 18
        remove_low_total(dealer_info)
        break
      end
    end
    
    hit(deck, dealer_info)
    display_table(dealer_info, player_info)
  end
end

def bust?(hash_info)
  hash_info[:total].all? { |total| total > 21 }
end

def compare_cards(dealer_info, player_info)
  dealer_high_total = dealer_info[:total].select { |x| x < 22 }.max
  player_high_total = player_info[:total].select { |x| x < 22 }.max
  return "push" if dealer_high_total == player_high_total
  dealer_high_total < player_high_total ? "You win" : "You lose"
end

def play_again?()
  loop do
    prompt('cash_or_bet')
    answer = gets.chomp

    return true if answer.downcase == '$'
    return false if answer.downcase == 'c'

    prompt('invalid_choice', "[c] or [$]")
  end
end

def reset_all_data(dealer_info, player_info)
  dealer_info = { cards: [], total: [], hole_card: false, display_total: false}
  player_info = { cards: [], total: []}

  dealer_info[:hole_card] = false
  dealer_info[:display_total] = false
end

while true
  dealer, player = initialize_players
  deck = shuffle_deck(initialize_deck)
  first_deal(deck, dealer, player)

  dealer[:total] = calculate_total(dealer)
  player[:total] = calculate_total(player)

  display_table(dealer, player)

  if blackjack?(dealer)
    reveal_dealer_info(dealer)
    remove_low_total(dealer) if has_low_high_totals?(dealer)

    display_table(dealer, player)
    puts "Dealer has blackjack. You lose"
    if play_again?
      # reset_all_data(dealer, player)
      next
    else
      break
    end
  end

  players_turn(deck, dealer, player)
  reveal_dealer_info(dealer)
  remove_low_total(player) if has_low_high_totals?(player)

  if bust?(player)
    display_table(dealer, player)
    puts "You busted! You lose!"
    if play_again?
      # reset_all_data(dealer, player)
      next
    else
      break
    end
  end

  dealers_turn(deck, dealer, player)
  remove_low_total(dealer) if has_low_high_totals?(dealer)
  
  if bust?(dealer)
    puts "Dealer busted! You win!" 
    if play_again?
      # reset_all_data(dealer, player)
      next
    else
      break
    end
  end

  display_table(dealer, player)

  puts compare_cards(dealer, player)

  if play_again?
    # reset_all_data(dealer, player)
    next
  else
    break
  end
  # reset_all_data(dealer, player)
end

puts "Thanks for playing"