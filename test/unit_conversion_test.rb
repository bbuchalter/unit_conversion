require "test_helper"

class UnitConversionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::UnitConversion::VERSION
  end

  def test_minute_to_s
    assert_equal "s", UnitConversion::Convert.new("minute").convert.unit_name
    assert_equal 60, UnitConversion::Convert.new("minute").convert.multiplication_factor
  end

  def test_min_to_s
    assert_equal "s", UnitConversion::Convert.new("min").convert.unit_name
    assert_equal 60, UnitConversion::Convert.new("min").convert.multiplication_factor
  end

  def test_hour_to_s
    assert_equal "s", UnitConversion::Convert.new("hour").convert.unit_name
    assert_equal 3600, UnitConversion::Convert.new("hour").convert.multiplication_factor
  end

  def test_h_to_s
    assert_equal "s", UnitConversion::Convert.new("h").convert.unit_name
    assert_equal 3600, UnitConversion::Convert.new("h").convert.multiplication_factor
  end

  def test_day_to_s
    assert_equal "s", UnitConversion::Convert.new("day").convert.unit_name
    assert_equal 86400, UnitConversion::Convert.new("day").convert.multiplication_factor
  end

  def test_d_to_s
    assert_equal "s", UnitConversion::Convert.new("d").convert.unit_name
    assert_equal 86400, UnitConversion::Convert.new("d").convert.multiplication_factor
  end

  def test_degree_to_rad
    assert_equal "rad", UnitConversion::Convert.new("degree").convert.unit_name
    assert_equal 0.01745329251994, UnitConversion::Convert.new("degree").convert.multiplication_factor
  end

  def test_degree_symbol_to_rad
    assert_equal "rad", UnitConversion::Convert.new("\u00B0").convert.unit_name
    assert_equal 0.01745329251994, UnitConversion::Convert.new("\u00B0").convert.multiplication_factor
  end

  def test_degree_minute_symbol_to_rad
    assert_equal "rad", UnitConversion::Convert.new("'").convert.unit_name
    assert_equal 0.00029088820867, UnitConversion::Convert.new("'").convert.multiplication_factor
  end

  def test_degree_second_to_rad
    assert_equal "rad", UnitConversion::Convert.new("second").convert.unit_name
    assert_equal 4.84813681e-06, UnitConversion::Convert.new("second").convert.multiplication_factor
  end

  def test_degree_second_symbol_to_rad
    assert_equal "rad", UnitConversion::Convert.new("\"").convert.unit_name
    assert_equal 4.84813681e-06, UnitConversion::Convert.new("\"").convert.multiplication_factor
  end

  def test_hectare_to_m2
    assert_equal "m2", UnitConversion::Convert.new("hectare").convert.unit_name
    assert_equal 10000, UnitConversion::Convert.new("hectare").convert.multiplication_factor
  end

  def test_ha_to_m2
    assert_equal "m2", UnitConversion::Convert.new("ha").convert.unit_name
    assert_equal 10000, UnitConversion::Convert.new("ha").convert.multiplication_factor
  end

  def test_litre_to_m2
    assert_equal "m3", UnitConversion::Convert.new("litre").convert.unit_name
    assert_equal 0.001, UnitConversion::Convert.new("litre").convert.multiplication_factor
  end

  def test_L_to_m3
    assert_equal "m3", UnitConversion::Convert.new("L").convert.unit_name
    assert_equal 0.001, UnitConversion::Convert.new("L").convert.multiplication_factor
  end

  def test_tonne_to_m3
    assert_equal "m3", UnitConversion::Convert.new("tonne").convert.unit_name
    assert_equal 10, UnitConversion::Convert.new("tonne").convert.multiplication_factor
  end

  def test_t_to_m3
    assert_equal "m3", UnitConversion::Convert.new("t").convert.unit_name
    assert_equal 10, UnitConversion::Convert.new("t").convert.multiplication_factor
  end
end

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
