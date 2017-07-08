# the user makes a choice
# the computer makes a choice
# the winner is displayed

# - rock beats scissors
# - scissors beats paper
# - paper beats rock

# If the players chose the same move, then it's a tie.

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def rock?
    @value == 'Rock'
  end

  def paper?
    @value == 'Paper'
  end

  def scissors?
    @value == 'Scissors'
  end

  def >(other_move)
    rock? && other_move.scissors? ||
      paper? && other_move.rock? ||
      scissors? && other_move.paper?
  end

  def <(other_move)
    rock? && other_move.paper? ||
      paper? && other_move.scissors? ||
      scissors? && other_move.rock?
  end
end

class RPSGame
  attr_accessor :human, :computer
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to game #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def display_moves
    puts "#{human.name} chose '#{human.move}'"
    puts "#{computer.name} chose '#{computer.move}'"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer
    end
    return true if answer == 'y'
    return false if answer == 'n'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    # @move = nil
    set_name
  end
end

class Human < Player
  def set_name
    answer = ''
    loop do
      puts "Please enter your name.."
      answer = gets.chomp
      break unless answer.empty?
    end
    self.name = answer.capitalize
  end

  def choose
    choice = nil
    loop do
      puts "Please choose 'rock', 'paper' or 'scissors':"
      choice = gets.chomp
      # break if choice =~ /([Rr]ock)|([Pp]aper)|([Ss]cissors)/
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice!"
    end
    self.move = Move.new(choice.capitalize)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Sonny', 'Chappie', 'iRobot'].sample
  end

  def choose
    # self.move = ['Rock', 'Paper', 'Scissors'].sample
    self.move = Move.new(Move::VALUES.sample.capitalize)
  end
end

RPSGame.new.play
