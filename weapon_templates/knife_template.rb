require_relative '../effects/critical_strike.rb'

class KnifeTemplate
    PERKS = {
      attack: 1
    }

    EFFECTS = [
      CriticalStrike.new(2, 30)
    ]

    def apply_perks
      return PERKS
    end

    def apply_effects
      return EFFECTS
    end

    def name
      return 'Knife'
    end
end