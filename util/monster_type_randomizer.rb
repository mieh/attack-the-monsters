require_relative '../monster_types/animal_monster.rb'
require_relative '../monster_types/humanoid_monster.rb'
require_relative '../monster_types/golems_monster.rb'


class MonsterTypeRandomizer
  POSSIBLE_MONSTER_TYPE = [AnimalMonster, HumanoidMonster, GolemsMonster]
  @instance = new

  private_class_method :new
  def self.instance
    @instance
  end

  def generate
    return POSSIBLE_MONSTER_TYPE.shuffle.first.instance
  end
end