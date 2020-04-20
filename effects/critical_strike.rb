require_relative 'no_effect.rb'
require_relative 'ignore_defense.rb'

class CriticalStrike
  attr_accessor :multiplier, :chances, :invoked

  def initialize(multiplier, chances)
    @multiplier = multiplier
    @chances = chances
  end

  def apply(ability, target)
    ability.modified_attack = calculate_damage(ability.modified_attack)

    @invoked.apply(ability, target)
  end

  def calculate_damage(attack)
    if generate_number < @chances
      @invoked = IgnoreDefense.instance
      show_critical
      return attack * multiplier
    end

    @invoked = NoEffect.instance
    return attack
  end

  def generate_number
    return rand(100)
  end

  def show_critical
    puts 'CRITICAL STRIKE!!!'
  end
end