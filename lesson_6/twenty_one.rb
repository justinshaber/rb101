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


def display_hands(dealer_hash, player_hash)
  puts "     Dealer"
  puts "    | | |#{dealer_hash[:cards][1]}|"
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

def deal_cards(deck, dealer_hash, player_hash)
  2.times do
    player_hash[:cards] << deck.shift
    dealer_hash[:cards] << deck.shift # only show dealers second card
  end
end

def calculate_total(hash_info, ace = 0)
  value = []
  hash_info[:cards].each do |card|
    if NUM_CARDS.include?(card[0])
      value << card[0].to_i
    elsif card[0] == 'A'

      value << ace
    else
      value << 10
    end
  end
  value.sum
end

def return_total(hash_info)
  case number_of_aces?(hash_info)
  when 0
    return [calculate_total(hash_info)]
  when 1
    low_total = calculate_total(hash_info, LOW_ACE)
    high_total = calculate_total(hash_info, HIGH_ACE)
    return [low_total, high_total]
  when 2
    if # conditional
      both_aces_low_total = calculate_total(hash_info, LOW_ACE)
      
      return [both_aces_low_total, one_ace_low_total]
    else
      low_total = calculate_total(hash_info, LOW_ACE)
      return low_total
    end
  end

  
  # if low_total == high_total
  #   return [low_total]
  # else
  #   return [low_total, high_total]
  # end
end

def display_total(hash_info)
  if hash_info[:total].size == 1
    return hash_info[:total][0]
  else
    return "#{hash_info[:total][0]} or #{hash_info[:total][1]}"
  end
end

def number_of_aces?(hash_info)
  hash_info[:cards].join.count("A")
end

deck = shuffle_deck(initialize_deck)
deal_cards(deck, dealer, player)

p dealer[:total] = return_total(dealer)
p player[:total] = return_total(player)

display_hands(dealer, player)

p ALL_CARDS.sort

