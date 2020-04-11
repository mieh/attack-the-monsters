require_relative 'weapon.rb'

class Character
  attr_accessor :attributes

  def initialize(name)
    @attributes = {
      hit_points: 20,
      name: name,
      attack: 5,
      defence: 1
    }
  end

  def equip_weapon(weapon)
    @attributes[:weapon] = weapon
  end

  def character_status
    return apply_weapon_perks(@attributes)
  end

  def apply_weapon_perks(attributes)
    return if attributes[:weapon].nil?

    return attributes[:weapon].apply_perks(attributes)
  end

  def attack
    attributes = character_status

    last_attack_value = attributes[:attack]
    attributes[:weapon].effects.each do |effect|
      last_attack_value = effect.calculate_damage(last_attack_value)
    end

    return last_attack_value
  end
end