class AnimalMonster
  PERKS = {
    attack: 1
  }
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def apply_perks(attributes)
    PERKS.each do |perk, v|
      attributes[perk] += v
    end
  end

  def name
    return 'Animal Monster'
  end

  def attack(attributes)
    return
  end
end