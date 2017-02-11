# m = p *  (j / (1 - (1 + j)**(-n)))
# START
# INPUT loan amount
# INPUT APR
# INPUT loan duration
#
# OUTPUT monthly interest rate
# OUTPUT monthly loan duration

require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

INTEREST = 5

def monthly_payment(la, n, j = INTEREST.to_f / 100)
  la * (j / (1 - (1 + j)**-n))
end

def messages(message)
  MESSAGES[message]
end

def prompt(message)
  puts MESSAGES[message].to_s
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def valid_number?(num)
  integer?(num) || float?(num)
end

la, n = ''

prompt('welcome')
prompt('loan_am')
loop do
  la = gets.chomp
  break if valid_number?(la)
  prompt('valid_number')
end

prompt('loan_dur')
loop do
  n = gets.chomp
  break if valid_number? n
  prompt('valid_number')
end

m = monthly_payment(la.to_f, n.to_f)
puts "your monthly payment is #{format('%02.2f', m)}"
