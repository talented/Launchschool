# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results
@language = 'en'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, @language)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

number1, number2 = ''

puts 'Do you want to change the default language to Turkish? Y/N'
selection = gets.chomp
@language = 'tr' if selection =~ /y/i

prompt('welcome')
name = ''
loop do
  name = gets.chomp
  if name.empty? || name.to_i.to_s == name
    prompt('valid_name')
  else
    break
  end
end

loop do # main loop
  loop do
    prompt('first_num')
    number1 = Kernel.gets.chomp
    if valid_number?(number1)
      break
    else
      prompt('valid_number')
    end
  end

  loop do
    prompt('second_num')
    number2 = Kernel.gets.chomp
    if valid_number?(number2)
      break
    else
      prompt('valid_number')
    end
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
    1 - add
    2 - subtract
    3 - multiply
    4 - divide
MSG

  puts operator_prompt.to_s
  operator = Kernel.gets.chomp
  loop do
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('valid operator')
    end
  end

  puts("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
  end

  puts("the result is #{result}!")
  prompt('perform_again')
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt('bye')
