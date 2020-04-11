require_relative '../weapon.rb'
require_relative '../perks/axe_perks.rb'
require_relative '../perks/sword_perks.rb'
require_relative '../perks/knife_perks.rb'
require_relative '../perks/none_perks.rb'

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
    attributes[:weapon] = Weapon.new([AxePerks, SwordPerks, KnifePerks, NonePerks].shuffle.first.new)
  end

  def modify(value, modifier)
    return value += modifier if !modifier.kind_of?(Array)

    return value += (modifier[1] == 'percent') ? value * (modifier[0].to_f/100) : modifier[0]
  end

  def name
    return 'Humanoid Monster'
  end

  def monster_status(attributes)
    return apply_weapon_perks(attributes)
  end

  def apply_weapon_perks(attributes)
    return if attributes[:weapon].nil?

    return attributes[:weapon].apply_perks(attributes)
  end

  def attack(attributes)
    attributes = character_status

    last_attack_value = attributes[:attack]
    attributes[:weapon].effects.each do |effect|
      last_attack_value = effect.calculate_damage(last_attack_value)
    end

    return last_attack_value
  end
end