# class GoodDog
#   attr_accessor :name, :height, :weight
#
#   def initialize(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end
#
#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end
#
#   def info
#     "#{self.name} is #{self.height} tall and weighs #{self.weight}"
#   end
#
#   def what_is_self
#     self
#   end
#
# puts self # => GoodDog
# end
#
# my_dog = GoodDog.new('toby', '25cm', '7kg')
#
# puts my_dog.weight # => 7kg
#
# my_dog.change_info('riko', '12cm', '4kg')
#
# puts my_dog.info # => riko is 12cm tall and weighs 4kg
#
# puts my_dog.what_is_self # => #<GoodDog:0x007f95671414d8>
# p my_dog.what_is_self # => #<GoodDog:0x007f95671414d8 @name="riko", @height="12cm", @weight="4kg">

class MyCar
  attr_accessor :year, :color, :model

  def self.calculate_gas(liters, km)
    @@gas_consumption = liters.to_f / km.to_f
    "total gas consumption is #{@@gas_consumption} liter per km"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def to_s
    ">> My car is a #{year} made #{model} in #{color} color"
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

my_car = MyCar.new('1965', 'blue', 'shelby')
puts my_car
# puts MyCar.calculate_gas(20, 400)
