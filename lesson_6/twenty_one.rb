require 'yaml'
MESSAGE = YAML.load_file('twenty_one_messages.yml')

SUITS = %w(c d h s)
CARDS = ("2".."10").to_a + %w(J Q K A)
dealer = { cards: [], total: 0, ace_total: 0}
player = { cards: [], total: 0, ace_total: 0}
players_cards = []


def display_hands(dealer_hash, player_hash)
  puts "     Dealer"
  puts "    | | |#{dealer_hash[:cards][1]}|"
  puts ""
  puts "    |#{player_hash[:cards][0]}| |#{player_hash[:cards][1]}| ==> #{player_hash[:total]}"
  puts "     Player"
end

def initialize_deck
  new_deck = []
  SUITS.each do |suit|
    CARDS.each do |card|
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

def calculate_total(hash_info)
  value = []
  hash_info[:cards].each do |card|
    if ("2".."10").to_a.include?(card[0])
      value << card[0].to_i
    elsif card[0] == 'A'
      value << 11
    else
      value << 10
    end
  end
  value
  value.sum
end

def handling_aces

end

deck = shuffle_deck(initialize_deck)
deal_cards(deck, dealer, player)

dealer[:total] = calculate_total(dealer)
player[:total] = calculate_total(player)

display_hands(dealer, player)


