# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def display_features
    puts "my car is #{self.year} made #{@model} with a #{self.color} color"
  end

  def speed_up(speed)
    @speed += speed
    puts "You push the gas and accelerate #{speed} km/hr"
  end

  def brake(speed)
    @speed -= speed
    puts "You push the brake and slow down #{speed} km/hr"
  end

  def current_speed
    puts "You are now going #{@speed} km/hr"
  end

  def change_color(color)
    self.color = color
  end

end

my_car = MyCar.new('1965', 'blue', 'Shelby')
my_car.display_features

my_car.current_speed

my_car.speed_up(20)

my_car.current_speed

my_car.brake(15)

my_car.current_speed

my_car.change_color('red')

my_car.display_features

# puts my_car.year
# puts my_car.model
