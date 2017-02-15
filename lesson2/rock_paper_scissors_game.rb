# user makes a choice
# computer makes a choice
# winner is displayed
VALID_CHOICES = %w(rock paper scissors lizard spock).freeze
WIN_MATCH = [%w(rock scissors), %w(rock lizard), %w(paper rock),
             %w(paper spock), %w(scissors paper), %w(scissors lizard),
             %w(lizard paper), %w(lizard spock), %w(spock rock), %w(spock scissors)].freeze

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear') || system('cls')
end

def abbreviation(choice)
  case choice
  when /^r$/i then 'rock'
  when /^p$/i then 'paper'
  when /^sc$/i then 'scissors'
  when /^l$/i then 'lizard'
  when /^sp$/i then 'spock'
  end
end

def win?(first, second)
  # (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
  #  (first == 'paper' && (second == 'rock' || second == 'spock')) ||
  #  (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
  #  (first == 'lizard' && (second == 'paper' || second == 'spock')) ||
  #  (first == 'spock' && (second == 'rock' || second == 'scissors'))
  winner = [first, second]
  WIN_MATCH.include?(winner)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You won!')
    puts('')
  elsif win?(computer, player)
    prompt('You lost!')
    puts('')
  elsif player == computer
    prompt("It's a tie!")
    puts('')
  end
end

loop do
  clear_screen
  prompt("Welcome to Rock-Paper-Scissors-Lizard-Spock game!\n")
  prompt('Whoever wins 5 games in total, he will be the champion!')
  puts('')

  player_count = 0
  computer_count = 0

  loop do
    user = ''
    loop do
      puts <<-MSG
=> Enter your selection:
=> r for rock
=> p for paper
=> sc for scissors
=> l for lizard
=> sp for spock

      MSG

      user = gets.chomp
      clear_screen
      user = abbreviation(user)
      break if VALID_CHOICES.include?(user)
      prompt("That's not a valid selection!")
    end

    computer = VALID_CHOICES.sample
    prompt("You chose: #{user}\n=> Computer chose: #{computer}")
    puts('')

    display_results(user, computer)
    if win?(user, computer)
      player_count += 1
    elsif win?(computer, user)
      computer_count += 1
    end

    if player_count == 5
      puts '**** You are the champion! ****'
      break
    elsif computer_count == 5
      puts ':( Computer is the champion! :('
      break
    else
      puts "You won #{player_count} games\nComputer won #{computer_count} games"
      puts('')
    end
  end
  puts('')
  prompt('Another game! Y/press any key to exit')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y') # answer !~ /y/i
end

prompt('Good bye!')
