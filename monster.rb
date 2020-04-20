require_relative 'util/monster_name_generator.rb'
require_relative 'ability.rb'
require_relative 'abilities/normal_attack.rb'
require_relative 'abilities/physical_defence.rb'

class Monster
  ATTACK = 0
  DEFEND = 1
  attr_accessor :attributes, :monster_type, :abilities, :ignore_defense

  def initialize(monster_type)
    @attributes = {
      hit_points: 30,
      name: MonsterNameGenerator.instance.generate,
      type: monster_type.name,
      attack: 3,
      defence: 0
    }
    @abilities = []

    @monster_type = monster_type
    @monster_type.apply_perks(@attributes)

    learn_abilities([Ability.new(self, NormalAttack)])
    learn_abilities([Ability.new(self, PhysicalDefence)])
  end

  def introduce
    print "========================================================== \n"
    print "name: #{@attributes[:name]} \n"
    print "monster type: #{@attributes[:type]} \n"
    print "attack: #{@attributes[:attack]} \n"
    print "defence: #{@attributes[:defence]} \n"
    print "weapon: #{@attributes[:weapon].name} \n" if !@attributes[:weapon].nil?
    print "========================================================== \n"
  end

  def learn_abilities(abilities)
    @abilities += abilities
  end

  def status
    return @monster_type.status(@attributes)
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
end