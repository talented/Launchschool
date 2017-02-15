# replace 'important' with 'urgent'
advice = 'Few things in life are as important as house training your pet dinosaur.'

advice.gsub!('important', 'urgent')
puts advice

# determine 42 is between 10-100
puts (10..100).cover?(42)

famous_words = "seven years ago..."
puts "Four score and " + famous_words
puts famous_words.prepend("Four score and ") #destructive
puts "Four score and " << famous_words

# turn the hash into an array containing only two elements
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

print flintstones.assoc("Barney")
puts flintstones

# check that "Spot" is present
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
puts ages.has_key?("Spot")
puts ages.include?("Spot")
puts ages.member?("Spot")
puts ages.key?("Lily")

# string manupulation
monsters = "The Monsters are creepy in a good way."
p monsters.capitalize
p monsters.swapcase
p monsters.upcase
p monsters.downcase

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?("Dino")
