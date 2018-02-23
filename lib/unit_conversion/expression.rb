module UnitConversion
  class Expression
    def initialize(expression)
      @expression = expression
    end

    def next_sub_expression
      if inner_paren_index
        expression.slice(inner_paren_index+1..first_closing_paren_index-1)
      else
        expression
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
