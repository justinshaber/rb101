require 'yaml'
MESSAGE = YAML.load_file('twenty_one_messages.yml')

SUITS = %w(c d h s)
NUM_CARDS = ("2".."10").to_a
FACE_CARDS = %w(J Q K A)
ALL_CARDS = NUM_CARDS + FACE_CARDS
BLACKJACK_PAYOUT = 1.50
MIN_BET = 5

players_bank = 100

def initialize_players(bank_amount)
  dealer = { cards: [], total: [], hole_card: false, display_total: false }
  player = { cards: [], total: [], bank: bank_amount, bet: nil }

  [dealer, player]
end

def prompt(message, options = '', option2 = '')
  puts format("=> #{MESSAGE[message]}", options: options, option2: option2)
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

def integer?(num)
  num.to_s.to_i.to_s == num.to_s
end

def bet(bank)
  prompt('bet', bank)
  answer = nil

  loop do
    answer = gets.chomp

    if integer?(answer)
      answer = answer.to_i
      break if answer >= MIN_BET && answer <= bank
    end
    prompt('invalid_choice', bank)
  end

  answer
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

def update_final_totals(dealer_info, player_info)
  reveal_dealer_info(dealer_info)
  remove_low_total(dealer_info) if soft_high_total?(dealer_info)
  remove_low_total(player_info) if soft_high_total?(player_info)
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

def blackjack?(hash_info)
  hash_info[:total].any? { |total| total == 21 }
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

    return true if answer.downcase == 'b'
    return false if answer.downcase == '$'

    prompt('invalid_choice', "[$] or [b]")
  end
end

def display_game_over(dealer_info, player_info, message)
  display_table(dealer_info, player_info)
  prompt(message, player_info[:bank])
end

def win_loss_amount(player_info, hand_result)
  original_bet = player_info[:bet]
  blackjack_winnings = original_bet * BLACKJACK_PAYOUT

  case hand_result
  when "blackjack"  then (original_bet + blackjack_winnings)
  when "normal_win" then (original_bet + original_bet)
  when "push"       then original_bet
  end
end

def no_money?(players_bank)
  players_bank < 5
end

def goodbye(players_bank)
  profit_loss = players_bank - 100
  prompt('thank_you')

  if no_money?(players_bank)
    return prompt('lost_it_all', profit_loss.abs, players_bank)
  end

  if profit_loss < 0
    prompt('lost_money', profit_loss.abs, players_bank)
  elsif profit_loss > 0
    prompt('won_money', profit_loss, players_bank)
  else
    prompt('broke_even')
  end
end

def hit_the_atm?
  loop do
    prompt('hit_the_atm')
    answer = gets.chomp

    return true if answer.downcase == '$'
    return false if answer.downcase == 'exit'

    system 'clear'
    prompt('invalid_input')
  end
end

loop do
  system 'clear'
  prompt('welcome')

  loop do
    dealer, player = initialize_players(players_bank)
    deck = shuffle_deck(initialize_deck)

    player[:bet] = bet(player[:bank])
    player[:bank] -= player[:bet]
    players_bank -= player[:bet]

    first_deal(deck, dealer, player)
    update_total(dealer)
    update_total(player)
    display_table(dealer, player)

    if blackjack?(dealer)
      update_final_totals(dealer, player)

      if blackjack?(player)
        display_game_over(dealer, player, "both_blackjack")
      else
        display_game_over(dealer, player, "dealer_blackjack")
      end

      break if no_money?(players_bank)
      play_again? ? next : break
    end

    players_turn(deck, dealer, player)

    if bust?(player)
      update_final_totals(dealer, player)

      display_game_over(dealer, player, "player_busted")
      break if no_money?(players_bank)
      play_again? ? next : break
    end

    dealers_turn(deck, dealer)

    if bust?(dealer)
      update_final_totals(dealer, player)

      if blackjack?(player)
        players_bank += win_loss_amount(player, 'blackjack')
        player[:bank] += win_loss_amount(player, 'blackjack')
      else
        players_bank += win_loss_amount(player, 'normal_win')
        player[:bank] += win_loss_amount(player, 'normal_win')
      end

      display_game_over(dealer, player, "dealer_busted")
      play_again? ? next : break
    end

    update_final_totals(dealer, player)
    result = compare_cards(dealer, player)
    if result == "win"
      if blackjack?(player)
        players_bank += win_loss_amount(player, 'blackjack')
        player[:bank] += win_loss_amount(player, 'blackjack')
      else
        players_bank += win_loss_amount(player, 'normal_win')
        player[:bank] += win_loss_amount(player, 'normal_win')
      end
    end
    players_bank += win_loss_amount(player, 'push') if result == "push"

    display_game_over(dealer, player, result)
    break if no_money?(players_bank)
    break unless play_again?
  end

  goodbye(players_bank)

  break unless no_money?(players_bank) && hit_the_atm?
  players_bank = 100
end
