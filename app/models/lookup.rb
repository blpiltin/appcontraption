class Lookup < ActiveRecord::Base
  attr_accessible :ac_type, :code, :name, :position

  HUMANIZED_ATTRIBUTES = {
    :ac_type => "Type"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end
