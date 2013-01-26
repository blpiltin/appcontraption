class GadgetType < ActiveRecord::Base
  attr_accessible :name

  has_many :gadgets
end
