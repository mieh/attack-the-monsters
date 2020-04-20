class Ability
  attr_accessor :user, :ability

  def initialize(user, ability)
    @user = user
    @ability = ability.new(user)
  end

  def perform(target)
    @ability.perform(target)
  end
end