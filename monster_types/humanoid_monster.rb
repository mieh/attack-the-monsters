require_relative '../weapon.rb'
require_relative '../util/weapon_templates_randomizer.rb'

class HumanoidMonster
  PERKS = {
    hit_points: [10, 'percent'],
    attack: 1,
    defence: 1
  }

  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def apply_perks(attributes)
    PERKS.each do |perk, v|
      attributes[perk] = modify(attributes[perk], v)
    end

    give_weapon(attributes)
  end

  def give_weapon(attributes)
    attributes[:weapon] = Weapon.new(WeaponTemplatesRandomizer.instance.generate)
  end

  def modify(value, modifier)
    return value += modifier if !modifier.kind_of?(Array)

    return value += (modifier[1] == 'percent') ? value * (modifier[0].to_f/100) : modifier[0]
  end

  def name
    return 'Humanoid Monster'
  end

  def status(attributes)
    return apply_weapon_perks(attributes)
  end

  private

  def apply_weapon_perks(attributes)
    return if attributes[:weapon].nil?

    return attributes[:weapon].apply_perks(attributes)
  end
end