require "test_helper"

class ConversionTest < Minitest::Test
  def test_equality
    day = UnitConversion::Convert.new("day").convert
    another_day = UnitConversion::Convert.new("day").convert
    assert_equal day, another_day
  end

  def test_days_per_hour
    day = UnitConversion::Convert.new("day").convert
    hour = UnitConversion::Convert.new("hour").convert
    hours_per_day = UnitConversion::Conversion.new(unit_name: 's/s', multiplication_factor: 24)
    assert_equal hours_per_day, day/hour
  end

  def test_degrees_per_minute
    degree = UnitConversion::Convert.new("degree").convert
    minute = UnitConversion::Convert.new("minute").convert
    degrees_per_minute = UnitConversion::Conversion.new(unit_name: 'rad/s', multiplication_factor: 0.00029088820867)
    assert_equal degrees_per_minute, degree/minute
  end

  def test_minutes_by_hectare
    minute = UnitConversion::Convert.new("minute").convert
    hectare = UnitConversion::Convert.new("hectare").convert
    minutes_by_hectare = UnitConversion::Conversion.new(unit_name: 's*m2', multiplication_factor: 600_000)
    assert_equal minutes_by_hectare, minute*hectare
  end

  def test_minutes_by_degree
    minute = UnitConversion::Convert.new("minute").convert
    degree = UnitConversion::Convert.new("degree").convert
    minutes_by_degree = UnitConversion::Conversion.new(unit_name: 's*rad', multiplication_factor: 1.0471975511964)
    assert_equal minutes_by_degree, minute*degree
  end
end
