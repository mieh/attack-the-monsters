require_relative 'weapon.rb'
require_relative 'ability.rb'
require_relative 'abilities/normal_attack.rb'
require_relative 'abilities/physical_defence.rb'

class Character
  ATTACK = 0
  DEFEND = 1
  attr_accessor :attributes, :abilities, :ignore_defense

  def initialize(name)
    @attributes = {
      hit_points: 20,
      name: name,
      attack: 5,
      defence: 1
    }
    @abilities = []

    learn_abilities([Ability.new(self, NormalAttack)])
    learn_abilities([Ability.new(self, PhysicalDefence)])
  end

  def introduce
    print "========================================================== \n"
    print "name: #{@attributes[:name]} \n"
    print "attack: #{@attributes[:attack]} \n"
    print "defence: #{@attributes[:defence]} \n"
    print "weapon: #{@attributes[:weapon].name} \n" if !@attributes[:weapon].nil?
    print "========================================================== \n"
  end

  def equip_weapon(weapon)
    @attributes[:weapon] = weapon
  end

  def learn_abilities(abilities)
    @abilities += abilities
  end

  def status
    return apply_weapon_perks(@attributes)
  end

  def attack(target)
    @abilities[ATTACK].perform(target)
  end

  def defend(attack_power)
    @abilities[DEFEND].perform(attack_power)
  end

  def damaged_by(damage)
    @attributes[:hit_points] -= damage
  end

  private

  def apply_weapon_perks(attributes)
    return if attributes[:weapon].nil?

    return attributes[:weapon].apply_perks(attributes)
  end
end