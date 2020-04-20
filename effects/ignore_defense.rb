class IgnoreDefense
  @instance = new

  def self.instance
    @instance
  end

  def apply(ability, target)
    target.ignore_defense = 1
  end
end