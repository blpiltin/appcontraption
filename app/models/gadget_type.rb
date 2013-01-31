class GadgetType < ActiveRecord::Base
  attr_accessible :name

  has_many :gadgets, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  
end
