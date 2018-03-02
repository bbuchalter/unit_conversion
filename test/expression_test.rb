require 'test_helper'

class ExpressionTest < Minitest::Test
  def test_next_sub_expression_single_paren
    expression = "(degree/min)"
    assert_equal "degree/min", UnitConversion::Expression.new(expression).next_sub_expression
  end

  def test_next_sub_expression_no_paren
    expression = "min"
    assert_equal "min", UnitConversion::Expression.new(expression).next_sub_expression
  end

  def test_next_sub_expression_multi_paren
    expression = "(degree/(minute*hectare))"
    assert_equal "minute*hectare", UnitConversion::Expression.new(expression).next_sub_expression
  end

  def test_operand_index_when_division_present
    expression = UnitConversion::Expression.new("day/hour")
    assert_equal 3, expression.operand_index
  end

  def test_operand_index_when_multiplication_present
    expression = UnitConversion::Expression.new("day*hour")
    assert_equal 3, expression.operand_index
  end

  def test_operand_index_when_absent
    expression = UnitConversion::Expression.new("day")
    assert_nil expression.operand_index
  end

  def test_operand_index_when_multiple
    expression = UnitConversion::Expression.new("day/hour/minute")
    assert_raises(ArgumentError) { expression.operand_index }
  end

  def test_evaluate_minute
    assert_equal(
      UnitConversion::Conversion.new(unit_name: 's', multiplication_factor: 60),
      UnitConversion::Expression.new('minute').evaluate
    )
  end

  def test_evaluate_minute_with_parens
    assert_equal(
      UnitConversion::Conversion.new(unit_name: 's', multiplication_factor: 60),
      UnitConversion::Expression.new('(minute)').evaluate
    )
  end

  def test_evaluate_degrees_per_minute
    assert_equal(
      UnitConversion::Conversion.new(unit_name: 'rad/s', multiplication_factor: 0.00029088820867),
      UnitConversion::Expression.new('degree/minute').evaluate
    )
  end

  def test_evaluate_degrees_per_minute_with_parens
    assert_equal(
      UnitConversion::Conversion.new(unit_name: 'rad/s', multiplication_factor: 0.00029088820867),
      UnitConversion::Expression.new('(degree/minute)').evaluate
    )
  end
end
