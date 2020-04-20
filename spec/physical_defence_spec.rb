require 'spec_helper'
require '../abilities/physical_defence.rb'
require '../character.rb'
require '../monster.rb'
require '../weapon.rb'
require '../weapon_templates/axe_template.rb'
require '../weapon_templates/sword_template.rb'
require '../weapon_templates/knife_template.rb'
require '../monster_types/animal_monster.rb'
require '../monster_types/golems_monster.rb'
require '../monster_types/humanoid_monster.rb'
require '../effects/critical_strike.rb'
require '../util/weapon_templates_randomizer.rb'


describe PhysicalDefence do
  let (:player)  { Character.new('Bambang') }
  let (:animal_monster)  { Monster.new(AnimalMonster.instance) }
  let (:humanoid_monster)  { Monster.new(HumanoidMonster.instance) }
  let (:golems)  { Monster.new(GolemsMonster.instance) }
  let (:sword)  { Weapon.new(SwordTemplate.new) }
  let (:axe)  { Weapon.new(AxeTemplate.new) }
  let (:axe_template)  { AxeTemplate.new }
  let (:sword_template)  { SwordTemplate.new }
  let (:no_weapon_template)  { NoneTemplate.new }

  context "on Player" do
    it "should have modified defence of 1 if not using weapon" do
      allow(player.abilities[1].ability).to receive(:damage_user).and_return(1)
      player.defend(1)
      expect(player.abilities[1].ability.modified_defence).to eq 1
    end

    it "should increase modified defence if using defence increasing weapon" do
      allow(player.abilities[1].ability).to receive(:damage_user).and_return(1)
      player.equip_weapon(sword)
      player.defend(1)
      expect(player.abilities[1].ability.modified_defence).to eq 3
    end

    it "should decreasee modified defence if using defence decreasing weapon" do
      allow(player.abilities[1].ability).to receive(:damage_user).and_return(1)
      player.equip_weapon(axe)
      player.defend(1)
      expect(player.abilities[1].ability.modified_defence).to eq 0
    end
  end

  context "on Monsters" do
    context "Animal" do
      it "should have modified defence of 0" do
        allow(animal_monster.abilities[1].ability).to receive(:damage_user).and_return(1)
        animal_monster.defend(1)
        expect(animal_monster.abilities[1].ability.modified_defence).to eq 0
      end
    end

    context "Humanoid" do
      it "should have modified defence of 1 if not using weapon" do
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(no_weapon_template)
        allow(humanoid_monster.abilities[1].ability).to receive(:damage_user).and_return(1)

        humanoid_monster.defend(1)
        expect(humanoid_monster.abilities[1].ability.modified_defence).to eq 1
      end

      it "should increase modified defence if using defence increasing weapon" do
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(sword_template)
        allow(humanoid_monster.abilities[1].ability).to receive(:damage_user).and_return(1)

        humanoid_monster.defend(1)
        expect(humanoid_monster.abilities[1].ability.modified_defence).to eq 3
      end

      it "should decreasee modified defence if using defence decreasing weapon" do
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(axe_template)
        allow(humanoid_monster.abilities[1].ability).to receive(:damage_user).and_return(1)

        humanoid_monster.defend(1)
        expect(humanoid_monster.abilities[1].ability.modified_defence).to eq 0
      end
    end

    context "Golems" do
      it "should have modified defence of 2" do
        allow(golems.abilities[1].ability).to receive(:damage_user).and_return(1)
        golems.defend(1)
        expect(golems.abilities[1].ability.modified_defence).to eq 2
      end
    end
  end

  context "Damage calculation" do
    context "when attack_power <= defence" do
      it "should damage half of the attack_power" do
        attack = 10
        defence = 20
        hitpoints = 30

        expect(animal_monster.attributes[:hit_points]).to eq hitpoints
        allow(animal_monster.abilities[1].ability).to receive(:final_defence_power).and_return(defence)

        animal_monster.defend(attack)
        expect(animal_monster.attributes[:hit_points]).to eq hitpoints - (attack * 0.5)
      end
    end

    context "when attack_power > defence" do
      it "should have damage 19 when attack power is 20" do
        attack = 20
        defence = 10
        hitpoints = 30

        expect(animal_monster.attributes[:hit_points]).to eq hitpoints
        allow(animal_monster.abilities[1].ability).to receive(:final_defence_power).and_return(defence)

        animal_monster.defend(attack)
        expect(animal_monster.attributes[:hit_points]).to eq hitpoints - (attack - (attack * (1.0/attack)))
      end

      it "should have damage 14 when attack power is 15" do
        attack = 15
        defence = 10
        hitpoints = 30

        expect(animal_monster.attributes[:hit_points]).to eq hitpoints
        allow(animal_monster.abilities[1].ability).to receive(:final_defence_power).and_return(defence)

        animal_monster.defend(attack)
        expect(animal_monster.attributes[:hit_points]).to eq hitpoints - (attack - (attack * (1.0/attack)))
      end

      it "should have damage 29 when attack power is 30" do
        attack = 30
        defence = 10
        hitpoints = 30

        expect(animal_monster.attributes[:hit_points]).to eq hitpoints
        allow(animal_monster.abilities[1].ability).to receive(:final_defence_power).and_return(defence)

        animal_monster.defend(attack)
        expect(animal_monster.attributes[:hit_points]).to eq hitpoints - (attack - (attack * (1.0/attack)))
      end
    end

    context "when defence is ignored" do
    end
  end
end