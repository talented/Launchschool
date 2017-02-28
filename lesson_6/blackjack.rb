# game name: blackjack
# features
# 52 cards - 4 suits (hearts, diamonds, clubs and spades) - 13 values(2,3,4,5,6,7,8,9,10, jack, queen, king, ace)
# the deal is to get 21 or closer
# consists of a dealer and player
# cards through 2-10 are worth their values. The jack, queen, king are worth 10 and the ace can be worth 1 or 11.

# pseudo-code
# initiate game and create deck
# pick up 2 random card for player and display them on screen
# pick up 1 random card for dealer and display in the same time (mention that there is another hidden card for dealer)
# start loop
# ask player to say "hit a card" or "stay" with current cards
# if the player say "hit", add a new random card to players card
# else if the player say "stay" show the other card of dealer (break loop)
# if players total of cards are more than 21, then display that the player busts (break loop)
# display winner of the play
# ask to play again

# AI for dealer: if player stays and if the total of dealers cards is less than 17 -> pick up a card for dealer else display the total of dealer

require 'io/console'
# require 'pry'

HIT_LIMIT = 17 # max. number for the dealer to decide hit or stay
WINNING = 3 # number to be reached to be the king of table

def prompt(msg)
  puts "==> #{msg}"
end

def clear_screen
  system('clear') || system('cls')
end

def valid_number?(num)
  num.to_s.to_i == num
end

def add_card
  str = ''
  random_card = rand(1..13)
  case random_card
  when 1
    str = 'Ace'
  when 11
    str = 'Jack'
  when 12
    str = 'Queen'
  when 13
    str = 'King'
  else
    str = random_card.to_s
  end
  str
end

def initialize_deck(dealer_cards, player_cards)
  dealer_cards.push(add_card)
  2.times do
    player_cards.push(add_card)
  end
end

def display_dealer(dealer_cards, delimiter = ' and ')
  if dealer_cards.size < 2
    prompt("Dealer has: #{dealer_cards[0]}#{delimiter}an unknown card")
  else
    prompt("Dealer has: #{dealer_cards[0, (dealer_cards.size - 1)].join(', ')}#{delimiter}#{dealer_cards.last}")
    prompt("Dealer's cards total is #{check_total(dealer_cards)}")
    puts ""
    prompt("*** BlackJack ***") if check_total(dealer_cards) == 21
  end
end

def display_player(player_cards, delimiter = ' and ')
  if player_cards.size < 3
    prompt("You have: #{player_cards[0]}#{delimiter}#{player_cards[1]}")
  else
    prompt("You have: #{player_cards[0, (player_cards.size - 1)].join(', ')}#{delimiter}#{player_cards.last}")
  end
  puts ""
  prompt("Your cards total is #{check_total(player_cards)}")
  puts ""
end

def check_total(cards)
  total = []
  deck_specials = ['Jack', 'Queen', 'King']

  # if any of deck_specials in hand
  if cards.any? { |card| deck_specials.include?(card) }
    worth_10 = cards.count { |card| deck_specials.include?(card) }
    total << (worth_10 * 10)
  end

  # if any number between 2-10 in hand
  cards.each { |card| total << card.to_i if valid_number?(card.to_i) }

  total_num = total.inject(:+)

  # if any Ace in hand
  if cards.include?('Ace')
    if total_num > 10
      total_num += cards.count('Ace')
    else
      total_num += 11
    end
  end

  total_num
end

def hit(player_cards)
  player_cards.push(add_card)
  clear_screen
end

def stand(dealer_cards)
  while check_total(dealer_cards) < HIT_LIMIT
    dealer_cards.push(add_card)
  end
  display_dealer(dealer_cards)
end

def display_score(player_score, dealer_score)
  prompt("Player score: #{player_score}")
  prompt("Dealer score: #{dealer_score}")
end

# initiate game
clear_screen
prompt("*** Welcome to BlackJack game! ***")
puts ""
prompt("Shuffling the cards, please be patient :)")
prompt("I hope you know the rules!")
prompt("Win #{WINNING} games to be the King of the table..")
puts ""
prompt("Press any key to continue..")
# gets
STDIN.getch
puts ""

loop do
  dealer_score = 0
  player_score = 0
  loop do
    dealer_cards = []
    player_cards = []

    initialize_deck(dealer_cards, player_cards)

    loop do
      clear_screen

      display_dealer(dealer_cards)
      display_player(player_cards)

      if check_total(player_cards) == 21
        prompt("*** BlackJack ***")
        break
      end

      display_score(player_score, dealer_score)
      puts ""
      prompt("Press H to hit or S to stand")
      answer = ''
      loop do
        answer = gets.chomp.downcase
        break if answer =~ /[hs]/
        prompt("Please enter a valid choice!")
      end

      if answer.start_with?('h')
        hit(player_cards)

        if check_total(player_cards) > 21
          puts ""
          display_dealer(dealer_cards)
          display_player(player_cards)
          prompt("You are busted! Dealer won..")
          dealer_score += 1
          break
        end

      else
        stand(dealer_cards)

        if check_total(dealer_cards) > 21
          puts ""
          prompt("Dealer is busted.. You won!")
          player_score += 1
          break
        end
        break
      end
    end

    player_total = check_total(player_cards)
    dealer_total = check_total(dealer_cards)

    puts "----------------------------------"
    if dealer_total <= 21 && player_total <= 21
      if dealer_total > player_total
        prompt("You lost!")
        dealer_score += 1
      elsif player_total > dealer_total
        puts ""
        prompt("You won!")
        player_score += 1
      else
        puts ""
        prompt("it's a tie!")
      end
    end
    puts ""
    display_score(player_score, dealer_score)
    puts""
    if player_score >= WINNING
      prompt "*** You are the King of the table! ***"
      break
    elsif dealer_score >= WINNING
      prompt "No chance today! try again later.."
      break
    else
      prompt("Press any key to continue..")
      # gets
      STDIN.getch
    end
  end
  puts "------------------------------------------"
  prompt("Do you want to play again? (Y)")
  answer = gets.chomp
  break if answer !~ /y/i
end

# exit game
prompt("Thanks for playing Blackjack! Good bye!")
puts "\n"
