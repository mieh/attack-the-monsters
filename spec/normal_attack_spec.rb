require 'spec_helper'
require '../abilities/normal_attack.rb'
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


describe NormalAttack do
  let (:player)  { Character.new('Bambang') }
  let (:animal_monster)  { Monster.new(AnimalMonster.instance) }
  let (:humanoid_monster)  { Monster.new(HumanoidMonster.instance) }
  let (:golems)  { Monster.new(GolemsMonster.instance) }
  let (:axe)  { Weapon.new(AxeTemplate.new) }
  let (:sword)  { Weapon.new(SwordTemplate.new) }
  let (:knife)  { Weapon.new(KnifeTemplate.new) }
  let (:no_weapon)  { Weapon.new(NoneTemplate.new) }
  let (:axe_template)  { AxeTemplate.new }
  let (:sword_template)  { SwordTemplate.new }
  let (:knife_template)  { KnifeTemplate.new }
  let (:no_weapon_template)  { NoneTemplate.new }

  context "Normal Attack should work for monsters and character" do
    context "on character" do
      it "should invoke perform" do
        expect(player.abilities[0]).to receive(:perform).with(animal_monster)
        player.attack(animal_monster)
      end

      it "should produce modified_attack of 7 when using sword" do
        allow(animal_monster).to receive(:defend).and_return(1)
        player.equip_weapon(sword)
        player.attack(animal_monster)
        expect(player.abilities[0].ability.modified_attack).to eq 7
      end

      it "should produce modified_attack of 9 when using Axe" do
        allow(animal_monster).to receive(:defend).and_return(1)
        player.equip_weapon(axe)
        player.attack(animal_monster)
        expect(player.abilities[0].ability.modified_attack).to eq 9
      end

      it "should produce modified_attack of 6 when using Knife with no critical invoked" do
        allow(animal_monster).to receive(:defend).and_return(1)
        player.equip_weapon(knife)
        allow(player.attributes[:weapon].effects.first).to receive(:generate_number).and_return 50

        player.attack(animal_monster)
        expect(player.abilities[0].ability.modified_attack).to eq 6
      end

      it "should produce modified_attack of 12 when using Knife with critical invoked" do
        allow(animal_monster).to receive(:defend).and_return(1)
        player.equip_weapon(knife)
        allow(player.attributes[:weapon].effects.first).to receive(:generate_number).and_return 20

        player.attack(animal_monster)
        expect(player.abilities[0].ability.modified_attack).to eq 12
      end
    end

    context "on animal_monster" do
      it "should invoke perform" do
        expect(animal_monster.abilities[0]).to receive(:perform).with(player)
        animal_monster.attack(player)
      end

      it "should produce modified_attack of 4" do
        allow(player).to receive(:defend).and_return(1)

        animal_monster.attack(player)
        expect(animal_monster.abilities[0].ability.modified_attack).to eq 4
      end
    end

    context "on humanoid_monster" do
      it "should invoke perform" do
        expect(humanoid_monster.abilities[0]).to receive(:perform).with(player)
        humanoid_monster.attack(player)
      end

      it "should produce modified_attack of 4 when using No Weapon" do
        allow(player).to receive(:defend).and_return(1)
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(no_weapon_template)

        humanoid_monster.attack(player)
        expect(humanoid_monster.abilities[0].ability.modified_attack).to eq 4
      end

      it "should produce modified_attack of 6 when using Sword" do
        allow(player).to receive(:defend).and_return(1)
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(sword_template)

        humanoid_monster.attack(player)
        expect(humanoid_monster.abilities[0].ability.modified_attack).to eq 6
      end

      it "should produce modified_attack of 8 when using Axe" do
        allow(player).to receive(:defend).and_return(1)
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(axe_template)

        humanoid_monster.attack(player)
        expect(humanoid_monster.abilities[0].ability.modified_attack).to eq 8
      end

      it "should produce modified_attack of 5 when using Knife with no critical invoked" do
        allow(player).to receive(:defend).and_return(1)
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(knife_template)
        allow(humanoid_monster.attributes[:weapon].effects.first).to receive(:generate_number).and_return 50

        humanoid_monster.attack(player)
        expect(humanoid_monster.abilities[0].ability.modified_attack).to eq 5
      end

      it "should produce modified_attack of 10 when using Knife with critical invoked" do
        allow(player).to receive(:defend).and_return(1)
        allow(WeaponTemplatesRandomizer.instance).to receive(:generate).and_return(knife_template)
        allow(humanoid_monster.attributes[:weapon].effects.first).to receive(:generate_number).and_return 29

        humanoid_monster.attack(player)
        expect(humanoid_monster.abilities[0].ability.modified_attack).to eq 10
      end
    end

    context "on golems" do
      it "should invoke perform" do
        expect(golems.abilities[0]).to receive(:perform).with(player)
        golems.attack(player)
      end

      it "should produce modified_attack of 3" do
        allow(player).to receive(:defend).and_return(1)

        golems.attack(player)
        expect(golems.abilities[0].ability.modified_attack).to eq 3
      end
    end
  end


end