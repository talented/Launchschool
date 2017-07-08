# class Parent
#   def say_hi
#     p "Hi from Parent"
#   end
# end
#
# puts Parent.superclass
#
# class Child < Parent
#
# end
#
# child = Child.new
# child.say_hi
# p child.instance_of? Child

# module Convertible
#   def is_convertible?
#     true
#   end
# end
#
# class Vehicle
#   attr_accessor :year, :color, :model
#   @@number_of_cars = 0
#
#   def self.calculate_gas(liters, km)
#     @@gas_consumption = liters.to_f / km.to_f
#     "total gas consumption is #{@@gas_consumption} liter per km"
#   end
#
#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     @@number_of_cars += 1
#   end
#
#   def self.vehicles_count
#     @@number_of_cars
#   end
#
#   def speed_up(speed)
#     @speed += speed
#     puts "You push the gas and accelerate #{speed} km/hr"
#   end
#
#   def brake(speed)
#     @speed -= speed
#     puts "You push the brake and slow down #{speed} km/hr"
#   end
#
#   def current_speed
#     puts "You are now going #{@speed} km/hr"
#   end
#
#   def change_color(color)
#     self.color = color
#   end
#
#   def to_s
#     ">> My #{self.class.to_s.gsub(/My/, '')} is a #{year} made #{model} in #{color} color"
#   end
#
#   def age
#     "Your #{self.model} is #{years_old} years old."
#   end
#
#   private
#
#   def years_old
#     Time.now.year - self.year
#   end
# end
#
# class MyCar < Vehicle
#   include Convertible
#   NUMBER_OF_DOORS = 4
#
#   # def to_s
#   #   ">> My car is a #{year} made #{model} in #{color} color"
#   # end
# end
#
# class MyTruck < Vehicle
#   NUMBER_OF_DOORS = 2
#
#   # def to_s
#   #   ">> My truck is a #{year} made #{model} in #{color} color"
#   # end
# end
#
# my_car = MyCar.new(1965, 'blue', 'shelby')
# puts my_car
# my_truck = MyTruck.new(2010, 'white', 'Tundra')
# puts my_truck
# puts my_car.age
# puts MyCar.calculate_gas(20, 400)
# puts Vehicle.vehicles_count
# puts my_car.is_convertible?
# #puts my_car.ancestors
# puts MyCar.ancestors

class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end

end

ozzy = Student.new('ozgur', 90)
jack = Student.new('jackie', 96)

puts ozzy.better_grade_than?(jack)
