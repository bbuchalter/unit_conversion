module UnitConversion
  class Expression
    def initialize(expression)
      @expression = expression
    end

    def evaluate
      if expression == next_sub_expression # a simple expression
        if operand_index # with an operation
          first_unit = expression.slice(0, operand_index)
          second_unit = expression.slice(operand_index+1..-1)
          operator = expression.slice(operand_index)

          first_unit_converted = Convert.new(first_unit).convert
          second_unit_converted = Convert.new(second_unit).convert
          first_unit_converted.send(operator, second_unit_converted)
        else # without an operation
          Convert.new(expression).convert
        end
      else # a complex expression
        self.class.new(next_sub_expression).evaluate
      end
    end

    def next_sub_expression
      if inner_paren_index
        expression.slice(inner_paren_index+1..first_closing_paren_index-1)
      else
        expression
      end
    end

    def operand_index
      expression_elements = expression.split(/[\/*]/)
      case(expression_elements.length)
      when 1 #no operands
        nil
      when 2 # one operand
        expression_elements[0].length
      else
        raise ArgumentError, "must provide an expression with zero or one operands"
      end
    end

    private

    attr_reader :expression

    def inner_paren_index
      expression.rindex("(")
    end

    def first_closing_paren_index
      expression.index(")")
    end
  end
end
