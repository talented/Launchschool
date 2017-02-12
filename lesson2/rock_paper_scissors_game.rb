# user makes a choice
# computer makes a choice
# winner is displayed
VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

def prompt(message)
  puts "=> #{message}"
end

def abbreviation(choice)
  case choice
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 'sc' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  end
end

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'lizard' && (second == 'paper' || second == 'spock')) ||
    (first == 'spock' && (second == 'rock' || second == 'scissors'))
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

puts('')
prompt("Welcome to Rock-Paper-Scissors-Lizard-Spock game!\n")
prompt('Whoever wins 5 games in total, he will be the champion!')
puts('')

loop do
  player_count = 0
  computer_count = 0

  loop do
    user = ''
    loop do
      operator_prompt = <<-MSG
Enter your selection:
=> r for rock
=> p for paper
=> sc for scissors
=> l for lizard
=> sp for spock

MSG
      puts "=> #{operator_prompt}"
      user = gets.chomp
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
  prompt('Another game! Y/N')
  answer = gets.chomp
  unless answer.downcase.start_with?('y') # answer !~ /y/i
    prompt('Good bye!')
    break
  end
end
