class Weapon
  attr_accessor :effects, :perks, :name

  def initialize(template)
    @name = template.name
    @perks = template.apply_perks
    @effects = []
    @effects = template.apply_effects if template.respond_to?(:apply_effects)
  end

  def apply_perks(attributes)
    modified_att = attributes.clone
    @perks.each do |perk, v|
      modified_att[perk] = modify(modified_att[perk], v)
    end

    return modified_att
  end

  def modify(value, modifier)
    return value += modifier if !modifier.kind_of?(Array)

    return value += modifier[1] == 'percent' ? value * (modifier[0].to_f/100) : modifier[0]
  end
end