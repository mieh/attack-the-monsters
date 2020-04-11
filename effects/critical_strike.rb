class CriticalStrike
  attr_accessor :multiplier, :chances

  def initialize(multiplier, chances)
    @multiplier = multiplier
    @chances = chances
  end

  def calculate_damage(attack)
    if generate_number < @chances
      return attack * multiplier
    end

    return attack
  end

  def generate_number
    return rand(100)
  end
end