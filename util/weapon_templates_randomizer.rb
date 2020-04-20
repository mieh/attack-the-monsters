require_relative '../weapon_templates/axe_template.rb'
require_relative '../weapon_templates/knife_template.rb'
require_relative '../weapon_templates/sword_template.rb'
require_relative '../weapon_templates/none_template.rb'


class WeaponTemplatesRandomizer
  POSSIBLE_WEAPON_TEMPLATE = [AxeTemplate, SwordTemplate, KnifeTemplate, NoneTemplate]
  @instance = new

  private_class_method :new
  def self.instance
    @instance
  end

  def generate
    return POSSIBLE_WEAPON_TEMPLATE.shuffle.first.new
  end
end