require_relative 'monster_name_generator.rb'

class Monster
  attr_accessor :attributes, :monster_type

  def initialize(monster_type)
    @attributes = {
      hit_points: 30,
      name: MonsterNameGenerator.instance.generate,
      type: monster_type.name,
      attack: 3,
      defence: 0
    }

    @monster_type = monster_type
    @monster_type.apply_perks(@attributes)
  end

  def attack
    @monster_type.attack(@attributes)
  end
end