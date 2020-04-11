require 'spec_helper'
require '../character.rb'
require '../weapon.rb'
require '../perks/axe_perks.rb'
require '../perks/sword_perks.rb'
require '../perks/knife_perks.rb'
require '../effects/critical_strike.rb'


describe Character do
  let (:axe)  { Weapon.new(AxePerks.new) }
  let (:sword)  { Weapon.new(SwordPerks.new) }
  let (:knife)  { Weapon.new(KnifePerks.new, [CriticalStrike.new(2, 30)]) }
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
        expect(@player.character_status[:attack]).to eq 7
        expect(@player.character_status[:defence]).to eq 3
      end
    end

    context "Equip Axe" do
      before do
        @player.equip_weapon(axe)
      end

      it "should modify attack to 9 and defence to 0" do
        expect(@player.character_status[:attack]).to eq 9
        expect(@player.character_status[:defence]).to eq 0
      end
    end

    context "Equip Knife" do
      before do
        @player.equip_weapon(knife)
      end

      it "should modify attack to 6" do
        expect(@player.character_status[:attack]).to eq 6
        expect(@player.character_status[:defence]).to eq 1
      end

      it "should modify attack to 6 when critical strike not invoked" do
        allow(@player.attributes[:weapon].effects.first).to receive(:generate_number).and_return 50

        expect(@player.attack).to eq 6
      end

      it "should modify attack to 12 when critical strike invoked" do
        allow(@player.attributes[:weapon].effects.first).to receive(:generate_number).and_return 20

        expect(@player.attack).to eq 12
      end
    end
  end
end