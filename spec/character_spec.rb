require 'spec_helper'
require '../character.rb'
require '../weapon.rb'
require '../weapon_templates/axe_template.rb'
require '../weapon_templates/sword_template.rb'
require '../weapon_templates/knife_template.rb'
require '../effects/critical_strike.rb'


describe Character do
  let (:axe)  { Weapon.new(AxeTemplate.new) }
  let (:sword)  { Weapon.new(SwordTemplate.new) }
  let (:knife)  { Weapon.new(KnifeTemplate.new) }
  let (:default_attributes) {
    {
      hit_points: 20,
      attack: 5,
      defence: 1
    }
  }

  context "Spawn Player Bambang" do
    before do
      @player = Character.new('Bambang')
    end

    it "should create Player with name Bambang" do
      expect(@player.attributes[:name]).to eq 'Bambang'
    end

    it "should have 20 hit_points, 5 attack, 1 defence" do
      expect(@player.attributes[:hit_points]).to eq 20
      expect(@player.attributes[:attack]).to eq 5
      expect(@player.attributes[:defence]).to eq 1
    end

    context "Equip Sword" do
      before do
        @player.equip_weapon(sword)
      end

      it "should modify attack to 7 and defence to 3" do
        expect(@player.status[:attack]).to eq 7
        expect(@player.status[:defence]).to eq 3
      end
    end

    context "Equip Axe" do
      before do
        @player.equip_weapon(axe)
      end

      it "should modify attack to 9 and defence to 0" do
        expect(@player.status[:attack]).to eq 9
        expect(@player.status[:defence]).to eq 0
      end
    end

    context "Equip Knife" do
      before do
        @player.equip_weapon(knife)
      end

      it "should modify attack to 6" do
        expect(@player.status[:attack]).to eq 6
        expect(@player.status[:defence]).to eq 1
      end

      it "should modify attack to 6 when critical strike not invoked" do
        allow(@player.attributes[:weapon].effects.first).to receive(:generate_number).and_return 50

        expect(@player.attack_modifier[0]).to eq 6
      end

      it "should modify attack to 12 when critical strike invoked" do
        allow(@player.attributes[:weapon].effects.first).to receive(:generate_number).and_return 20

        expect(@player.attack_modifier[0]).to eq 12
      end
    end
  end
end