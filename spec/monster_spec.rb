require 'spec_helper'
require '../monster.rb'
require '../monster_types/animal_monster.rb'
require '../monster_types/golems_monster.rb'
require '../monster_types/humanoid_monster.rb'


describe Monster do
  let (:animal_monster)  { AnimalMonster.instance }
  let (:humanoid_monster)  { HumanoidMonster.instance }
  let (:golems)  { GolemsMonster.instance }

  context "Spawn Animal Monster" do
    it "should create monster with type Animal Monster" do
      new_monster = Monster.new(animal_monster)

      expect(new_monster.attributes[:type]).to eq animal_monster.name
    end

    it "should create monster with attack of 4, defense 0, hit points of 30" do
      new_monster = Monster.new(animal_monster)

      expect( new_monster.attributes[:attack] ).to eq 4
      expect( new_monster.attributes[:defence] ).to eq 0
      expect( new_monster.attributes[:hit_points] ).to eq 30
    end
  end

  context "Spawn Humanoid Monster" do
    it "should create monster with type Humanoid Monster" do
      new_monster = Monster.new(humanoid_monster)

      expect(new_monster.attributes[:type]).to eq humanoid_monster.name
    end

    it "should have weapon" do
      new_monster = Monster.new(humanoid_monster)

      expect(new_monster.attributes[:weapon]).not_to be nil
    end

    it "should create monster with attack of 4, defense of 1, and hit points of 33" do
      new_monster = Monster.new(humanoid_monster)

      expect( new_monster.attributes[:attack] ).to eq 4
      expect( new_monster.attributes[:defence] ).to eq 1
      expect( new_monster.attributes[:hit_points] ).to eq 33
    end
  end

  context "Spawn Golems Monster" do
    it "should create monster with type Golems Monster" do
      new_monster = Monster.new(golems)

      expect(new_monster.attributes[:type]).to eq golems.name
    end

    it "should create monster with attack of 3, defense of 2, and hit points of 36" do
      new_monster = Monster.new(golems)

      expect( new_monster.attributes[:attack] ).to eq 3
      expect( new_monster.attributes[:defence] ).to eq 2
      expect( new_monster.attributes[:hit_points] ).to eq 36
    end
  end
end