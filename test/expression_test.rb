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
end
