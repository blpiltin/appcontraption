class MenuCategory < ActiveRecord::Base
	image_accessor :icon
  attr_accessible :description, :name,
  	:icon, :retained_icon, :remove_icon

  belongs_to :gadget

  validates_uniqueness_of :name, scope: :gadget_id, \
    message: "must be unique for each menu category in menu."
  validates :name, presence: true, length: {maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :gadget_id, presence: true

  default_scope order: 'menu_categories.position'

 	before_save :default_values

	private
    def default_values
      self.position = 
      	position.blank? ? gadget.menu_categories.count + 1 : position
  	end
end
