require 'minitest/autorun'

require_relative 'car'

class CarTest < Minitest::Test

#assert

  def test_car_exists
    car = Car.new
    assert(car)
  end

#assert_equal

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

#assert_nil

  def test_name_is_nil
    car = Car.new
    assert_nil(car.name)
  end

#assert_raises

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")         # this code raises ArgumentError, so this assertion passes
    end
  end

#assert_instance_of

  def test_instance_of_car
    car = Car.new
    assert_instance_of(Car, car)
  end

#assert_includes

  def test_includes_car
    car = Car.new
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car)
  end
end

# assert_includes calls assert_equal in its implementation, and Minitest counts
# that call as a separate assertion. For each assert_includes call, you will
# get 2 assertions, not 1.

#Change our class to take out the redundant object creation

class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end

  def test_car_exists
    assert(@car)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      Car.new(name: "Joey")
    end
  end

  def test_instance_of_car
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end
