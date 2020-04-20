class NormalAttack
  attr_accessor :user, :modified_attack

  def initialize(user)
    @user = user
    @modified_attack = 0
  end

  def perform(target)
    @modified_attack = final_attack_power

    show_attack(target)
    apply_effects(target)
    target.defend(@modified_attack)
    reset_target_defense(target)
  end

  def attack_modifier
    {
      attack_power: [
        user_attack_attribute,
        user_weapon_attack_bonus
      ],
      effects: [
        user_weapon_effects
      ]
    }
  end

  private

  def user_attack_attribute
    @user.attributes[:attack]
  end

  def user_weapon_attack_bonus
    return if @user.attributes[:weapon].nil?

    @user.attributes[:weapon]&.perks[:attack]
  end

  def user_weapon_effects
    return if @user.attributes[:weapon].nil?

    @user.attributes[:weapon]&.effects
  end

  def final_attack_power
    attack = 0
    attack_modifier[:attack_power].compact.each do |modifier|
      attack += modifier
    end

    return attack
  end

  def apply_effects(target)
    attack_modifier[:effects].flatten.compact.each do |effect|
      effect.apply(self, target)
    end
  end

  def reset_target_defense(target)
    target.ignore_defense = 0
  end

  def show_attack(target)
    puts "#{@user.attributes[:name]} attack #{target.attributes[:name]} with attack power: #{@modified_attack}"
  end
end