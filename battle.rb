require_relative 'monster.rb'
require_relative 'character.rb'
require_relative 'util/monster_type_randomizer.rb'
require_relative 'weapon_templates/axe_template.rb'
require_relative 'weapon_templates/knife_template.rb'
require_relative 'weapon_templates/sword_template.rb'
require_relative 'effects/critical_strike.rb'
require 'byebug'

class Battle
  def initialize
    monster_type = MonsterTypeRandomizer.instance.generate
    @monster = Monster.new(monster_type)

    @player = Character.new('Player 1')
    weapons = init_weapons
    @player.equip_weapon(weapons.shuffle.first)
  end

  def perform
    contestants = [@player, @monster]
    introducing(contestants)

    turn = flip_coin
    iterator = 1
    while (!one_of_them_dead(contestants))
      puts "============= Turn #{iterator} ==============="
      contestants[turn].attack(contestants[(next_contestant(turn))])

      puts "#{contestants[next_contestant(turn)].attributes[:name]} has #{contestants[next_contestant(turn)].attributes[:hit_points]} hit points remaining"
      turn = next_contestant(turn)
      iterator += 1
      puts "============================================="
    end

    anounce_the_victor(contestants)
  end

  private

  def init_weapons
    sword = Weapon.new(SwordTemplate.new)
    axe = Weapon.new(AxeTemplate.new)
    knife = Weapon.new(KnifeTemplate.new)
    return [sword, axe, knife]
  end

  def flip_coin
    rand(2)
  end

  def one_of_them_dead(contestants)
    hit_points = contestants.map { |contestant| contestant.attributes[:hit_points] }
    return hit_points.inject(:*) <= 0
  end

  def anounce_the_victor(contestants)
    victor = contestants.select { |contestant| contestant.attributes[:hit_points] > 0}
    puts "The winner is #{victor.first.attributes[:name]}"
  end

  def print_name(contestant)
    print "#{contestant.attributes[:name]} "
  end

  def introducing(contestants)
    contestants.each do |contestant|
      contestant.introduce
    end
  end

  def next_contestant(turn)
    (turn + 1) % 2
  end
end