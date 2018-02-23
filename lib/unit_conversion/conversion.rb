module UnitConversion
  class Conversion
    attr_reader :unit_name, :multiplication_factor
    def initialize(unit_name:, multiplication_factor:)
      @unit_name = unit_name
      @multiplication_factor = multiplication_factor
    end

    def ==(other)
      unit_name == other.unit_name && multiplication_factor == other.multiplication_factor
    end

    def /(operand)
      new_unit = "#{unit_name}/#{operand.unit_name}"
      new_factor = (multiplication_factor / operand.multiplication_factor.to_f).round(14)

      self.class.new(
        unit_name: new_unit,
        multiplication_factor: new_factor
      )
    end

    def *(operand)
      new_unit = "#{unit_name}*#{operand.unit_name}"
      new_factor = (multiplication_factor * operand.multiplication_factor.to_f).round(14)

      self.class.new(
        unit_name: new_unit,
        multiplication_factor: new_factor
      )
    end
  end
end
