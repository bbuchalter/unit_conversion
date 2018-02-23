require "unit_conversion/version"

module UnitConversion
  class Convert
    def initialize(unit)
      @unit = unit
    end

    def convert
      Conversion.new(
        find_unit
      )
    end

    private

    attr_reader :unit

    def find_unit
      conversion_map.each_pair do |units, conversion|
        if units.include?(unit)
          return conversion
          break
        end
      end
      raise ArgumentError, "#{unit} has no conversion defined"
    end

    def conversion_map
      @conversion_map ||= {
        ['minute', 'min'] => { unit_name: 's', multiplication_factor: 60 },
        ['h', 'hour'] => { unit_name: 's', multiplication_factor: 3600 },
        ['d', 'day'] => { unit_name: 's', multiplication_factor: 86400 },
        ['degree', "\u00B0"] => { unit_name: 'rad', multiplication_factor: (Math::PI/180).round(14) },
        ["'"] => { unit_name: 'rad', multiplication_factor: (Math::PI/10800).round(14) },
        ["second", "\""] => { unit_name: 'rad', multiplication_factor: (Math::PI/648000).round(14) },
        ["hectare", "ha"] => { unit_name: 'm2', multiplication_factor: 10000 },
        ["litre", "L"] => { unit_name: 'm3', multiplication_factor: 0.001 },
        ["tonne", "t"] => { unit_name: 'm3', multiplication_factor: 10 },
      }
    end

  end

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
