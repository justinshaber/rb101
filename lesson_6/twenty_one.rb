require 'pry-byebug'
require 'yaml'
MESSAGE = YAML.load_file('twenty_one_messages.yml')

SUITS = %w(c d h s)
NUM_CARDS = ("2".."10").to_a 
FACE_CARDS = %w(J Q K)
ACE = %w(A)
ALL_CARDS = NUM_CARDS + FACE_CARDS + ACE
LOW_ACE = 1
HIGH_ACE = 11

dealer = { cards: [], total: []}
player = { cards: [], total: []}

def prompt(message, options = '')
  puts format("=> #{MESSAGE[message]}", options: options)
end

def display_hands(dealer_hash, player_hash)
  puts "     Dealer"
  puts "    | | |#{dealer_hash[:cards][1]}| ==> #{display_total(dealer_hash)}"
  puts ""
  puts "    |#{player_hash[:cards][0]}| |#{player_hash[:cards][1]}| ==> #{display_total(player_hash)}"
  puts "     Player"
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

  if aces.size == 1
    low_total = non_ace_total + LOW_ACE
    high_total = non_ace_total + HIGH_ACE

    totals = []
    totals << low_total if low_total <= 21
    totals << high_total if high_total <= 21

    return totals
  end

  if aces.size == 2
    low_total = non_ace_total + LOW_ACE + LOW_ACE
    high_total = non_ace_total + HIGH_ACE + LOW_ACE

    totals = []
    totals << low_total if low_total <= 21
    totals << high_total if high_total <= 21

    return totals
  end

  [non_ace_total]
end

def display_total(hash_info)
  if hash_info[:total].size == 1
    return hash_info[:total][0]
  else
    return "#{hash_info[:total][0]} or #{hash_info[:total][1]}"
  end
end

# def number_of_aces?(hash_info)
#   hash_info[:cards].join.count("A")
# end

def hit_or_stay?(deck, player_info)
  loop do
    prompt("hit_or_stay?")
    answer = gets.chomp.downcase

    return answer if answer == "h"
    return answer if answer == "s"
    prompt("invalid_response")
  end
end

def hit(deck, hash_info)
  deal_a_card(deck, hash_info)
  p hash_info[:cards]
  p hash_info[:total] = calculate_total(hash_info)
end

def players_turn(deck, player_info)
  loop do
    choice = hit_or_stay?(deck, player_info)
    hit(deck, player_info) if choice == 'h'
    break if choice == 's' || bust?(player_info)
  end
end

def dealers_turn(deck, dealer_info)
  loop do
    if dealer_info[:total].any? { |total| total < 17 }
      hit(deck, dealer_info)
    else
      break
    end
  end
end

def bust?(hash_info)
  hash_info[:total].all? { |total| total > 21 }
end

def compare_cards(dealer_info, player_info)
  dealer_high_total = dealer_info[:total].select { |x| x < 21 }.max
  player_high_total = player_info[:total].select { |x| x < 21 }.max
  dealer_high_total < player_high_total ? "You win" : "You lose"
end

loop do
  deck = shuffle_deck(initialize_deck)
  first_deal(deck, dealer, player)

  p dealer[:cards]
  p dealer[:total] = calculate_total(dealer)

  p player[:cards]
  p player[:total] = calculate_total(player)

  display_hands(dealer, player)

  players_turn(deck, player)
  if bust?(player)
    puts "You busted! You lose!" 
    break
  end

  dealers_turn(deck, dealer)
  
  if bust?(dealer)
    puts "Dealer busted! You win!" 
    break
  end

  display_hands(dealer, player)

  p compare_cards(dealer, player)
  break
end

puts "Thanks for playing"