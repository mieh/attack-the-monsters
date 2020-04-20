require 'byebug'

class PhysicalDefence
  attr_accessor :user, :modified_defence

  def initialize(user)
    @user = user
    @modified_defence = 0
  end

  def perform(attack_power)
    @modified_defence = final_defence_power
    damage_user(attack_power)
  end

  def defence_modifier
    {
      defence_power: [
        user_defence_attribute,
        user_weapon_defence_bonus
      ]
    }
  end

  private

  def user_defence_attribute
    @user.attributes[:defence]
  end

  def user_weapon_defence_bonus
    return if @user.attributes[:weapon].nil?

    @user.attributes[:weapon]&.perks[:defence]
  end

  def final_defence_power
    defence = 0
    defence_modifier[:defence_power].compact.each do |modifier|
      defence += modifier
    end

    return defence
  end

  def damage_user(attack_power)
    return if attack_power <= 0

    if @user.ignore_defense == 0
      @user.damaged_by(attack_power)
      return
    end

    damage = attack_power - blocked_attack(attack_power)
    show_damage(damage)
    @user.damaged_by(damage)
  end

  def blocked_attack(attack_power)
    defence_percentage(attack_power)[defence_mode(attack_power)] * attack_power
  end

  def defence_percentage(attack_power)
    [50.0/100, 1.0/attack_power]
  end

  def defence_mode(attack_power)
    (attack_power > @modified_defence) ? 1 : 0
  end

  def show_damage(damage)
    puts "#{@user.attributes[:name]} damaged by #{damage}"
  end
end