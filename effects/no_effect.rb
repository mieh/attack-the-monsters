class NoEffect
  @instance = new

  def self.instance
    @instance
  end

  def apply(ability, target)
  end
end