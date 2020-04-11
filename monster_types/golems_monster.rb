class GolemsMonster
  PERKS = {
    hit_points: [20, 'percent'],
    defence: 2
  }
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def apply_perks(attributes)
    PERKS.each do |perk, v|
      attributes[perk] = modify(attributes[perk], v)
    end
  end

  def modify(value, modifier)
    return value += modifier if !modifier.kind_of?(Array)

    return value += modifier[1] == 'percent' ? value * (modifier[0].to_f/100) : modifier[0]
  end

  def name
    return 'Golems'
  end
end