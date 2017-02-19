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
require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

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
  valid_integer?(value) && value.to_i.between?(1,9)

end

def display_board(brd)
  clear_screen
  puts ""
  puts "     You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
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
  (1..9).each {|num| new_board[num] = INITIAL_MARKER}
  new_board
end

def empty_squares(brd)
  brd.keys.select {|num| brd[num] == INITIAL_MARKER}
end


def player_places_piece(cur_brd)
  square = ''
  loop do
  prompt "Choose a square (#{empty_squares(cur_brd).join(', ')}):"
  square = gets.chomp.to_i
  #break if valid_value?(square)
  break if empty_squares(cur_brd).include?(square)
  prompt "Please enter a valid value!"
  end
  cur_brd[square] = PLAYER_MARKER
end

def computer_places_piece(brd)
  #num = Random.rand(1..9)
  #binding.pry
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end


def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonals
  winning_lines.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
       return 'Player'
     elsif
       brd[line[0]] == COMPUTER_MARKER &&
       brd[line[1]] == COMPUTER_MARKER &&
       brd[line[2]] == COMPUTER_MARKER
       return 'Computer'
     end
  end
  nil
end

loop do

  # definitions
  board = initialize_board

  # start
  loop do
    display_board(board)
    # user marks square
    player_places_piece(board)
    # winner? check that board is full
    break if winner?(board) || board_full?(board)

    # computer marks square
    computer_places_piece(board)
    # winner? check that board is full
    break if winner?(board) || board_full?(board)
  end

  display_board(board)
  # display winner or display tie
  if winner?(board)
    prompt ("#{detect_winner(board)} won!")
  else
    prompt ("It's a tie!")
  end

  # ask to play again
  puts "\n"
  prompt("Do you want to play again? (Y or Press any key to exit)")
  answer = gets.chomp
  break if answer !~ /y/i
end

# exit game
prompt("Thanks for playing Tic Tac Toe. Good bye!")
puts "\n"
