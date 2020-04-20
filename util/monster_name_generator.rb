require_relative 'monster_name_generator.rb'

class MonsterNameGenerator
  POSSIBLE_NAME = ['pikachu', 'kurama', 'parjo']
  @instance = new

  private_class_method :new
  def self.instance
    @instance
  end

  def generate
    idx = rand(POSSIBLE_NAME.size)
    return POSSIBLE_NAME[idx]
  end
end