=begin
1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!
=end

require 'io/console'

COMPUTER = 'Computer'
PLAYER = 'Player'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagonals

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('cls') || system('clear')
end

def valid_integer?(num)
  num.to_i.to_s == num
end

def valid_value?(value)
  valid_integer?(value) && value.to_i.between?(1, 9)
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  clear_screen
  puts ""
  prompt("You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}.")
  prompt("Win 3 game to be the Champion!")
  puts ""
  puts "\t     |     |"
  puts "\t  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "\t     |     |"
  puts "\t-----+-----+-----"
  puts "\t     |     |"
  puts "\t  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "\t     |     |"
  puts "\t-----+-----+-----"
  puts "\t     |     |"
  puts "\t  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "\t     |     |"
  puts ''
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def alternate_player(current_player)
  if current_player == COMPUTER
    current_player = PLAYER
  else
    current_player = COMPUTER
  end
end

def place_piece!(brd, current_player)
  if current_player == COMPUTER
    computer_places_piece(brd)
  else
    player_places_piece(brd)
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter = ', ', phrase = 'or')
  "#{(arr - [arr.last]).join(delimiter)}#{arr.size == 1 ? '' : ' ' + phrase + ' '}#{arr.last}"
end

def player_places_piece(cur_brd)
  player_square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(cur_brd))}):"
    player_square = gets.chomp.to_i
    # break if valid_value?(square)
    break if empty_squares(cur_brd).include?(player_square)
    prompt "Please enter a valid value!"
  end
  cur_brd[player_square] = PLAYER_MARKER
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def computer_places_piece(brd)
  square = nil

  # defense
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  # offense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square
    if brd[5] == INITIAL_MARKER
      square = 5
    else
      square = empty_squares(brd).sample
    end
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    # if brd[line[0]] == PLAYER_MARKER &&
    #    brd[line[1]] == PLAYER_MARKER &&
    #    brd[line[2]] == PLAYER_MARKER
    #   return 'Player'
    # elsif brd[line[0]] == COMPUTER_MARKER &&
    #       brd[line[1]] == COMPUTER_MARKER &&
    #       brd[line[2]] == COMPUTER_MARKER
    #   return 'Computer'
    # end
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def display_winner(player, computer)
  prompt("Computer score: #{computer}")
  prompt("Your score: #{player}")
end

loop do
  player_won = 0
  computer_won = 0
  current_player = PLAYER # set default player

  clear_screen
  puts ""
  prompt("Please choose who goes first? Enter P for player or C for computer.")
  letter = ''
  loop do
    letter = gets.chomp
    break if letter =~ /[pc]/i
    prompt("Please enter only P or C to continue!")
  end

  loop do
    # definitions
    board = initialize_board
    letter =~ /c/i ? current_player = COMPUTER : current_player = PLAYER

    # start
    loop do
      display_board(board)

      puts "\n"
      # display winner
      display_winner(player_won, computer_won)
      puts "\n"

      # marks square
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)

      # winner? check that board is full
      break if winner?(board) || board_full?(board)
    end

    display_board(board)
    # display winner or display tie
    if winner?(board)
      prompt "#{detect_winner(board)} won!"
      detect_winner(board) == 'Player' ? player_won += 1 : computer_won += 1
    else
      prompt "It's a tie!"
    end

    if player_won == 3 || computer_won == 3
      puts "\n"
      prompt("**** #{detect_winner(board)} is the Champion! ****")
      puts "\n"
      break
    else
      prompt("Press any key to continue..")
      # gets
      STDIN.getch
    end
  end
  # ask to play again
  prompt("Do you want to play again? (Y)")
  answer = gets.chomp
  break if answer !~ /y/i
end

# exit game
prompt("Thanks for playing Tic Tac Toe. Good bye!")
puts "\n"
