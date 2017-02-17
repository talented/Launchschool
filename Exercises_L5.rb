# 1
arr = ['10', '11', '9', '7', '8']
arr.map! {|v| v.to_i }.sort.reverse
arr.sort {|a,b| b.to_i <=> a.to_i }

# 2
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysees', author: 'James Joyce', published: '1922'}
]
#books.sort {|a,b| a[:published].to_i <=> b[:published].to_i  }
books.sort_by {|a| a[:published].to_i }

#3
arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].key(0)

#4
arr1 = [1, [2, 3], 4]
arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4
hsh2

#5
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

hash = munsters.values
sum = 0
munsters.values.each {|spec| sum += spec['age'] if spec['gender'] == 'male'}
munsters.each_value {|spec| sum += spec['age'] if spec['gender'] == 'male' }
sum

#6 
munsters.each do |key, values|
  "#{key} is a #{values['age']} years old #{values['gender']}"
end

#7 
a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

#8 
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}
hsh.values.each {|arr| arr.map! {|str| str.scan(/[aeoui]/) } }.flatten.join

#9
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
arr.map {|ar| ar.sort!.reverse }
arr.map {|ar| ar.sort {|a,b| b <=> a } } 

#10
#[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map {|hash| hash.each {|k,v| hash[k] += 1 } }

hash = {}
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map {|hsh| hsh.each {|k,v| hash[k] = v + 1 } }
hash

#11
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
arr.map {|ar| ar.select {|v| v%3 == 0 } }.delete_if {|val| val.empty? }

#12 
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
arr.each_with_object({}) {|ar, hsh| hsh[ar[0]] = ar[1] }

#13
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
arr.sort_by {|ar| ar.select {|v| v.odd? } }
#[[1, 8, 3], [1, 6, 7], [1, 4, 9]]

#14
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}
array = []
hsh.values.each do |hash|
  array << hash[:colors].each{|str| str.capitalize!} if hash[:type] == 'fruit'
  array << hash[:size].upcase if hash[:type] == 'vegetable'
end
array

#15 
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
arr.select {|hash| hash.all? {|k,v| v.all? {|val| val.even? } } }

#16 
def random_uuid
  #8-4-4-4-12
  arr = []
 # 32.times { arr << num = Random.rand(16).to_s(16) }
 # arr.insert(8, '-')
 # arr.insert(13, '-')
 # arr.insert(18, '-')
 # arr.insert(23, '-')
   sections = [8,4,4,4,12]
   sections.each do |val|
     val.times { arr << num = Random.rand(16).to_s(16) }
     arr << '-' unless val == 12
   end
   arr.join
end
random_uuid
