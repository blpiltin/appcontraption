class MenuItem < ActiveRecord::Base
	image_accessor :image
  attr_accessible :name, :description, :price,
  	:image, :retained_image, :remove_image

  belongs_to :menu_category

  validates_uniqueness_of :name, scope: :menu_category_id, \
    message: "must be unique for each menu item in menu category."
  validates :name, presence: true, length: {maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :price, presence: true, 
  	format: { with: /^\d+??(?:\.\d{0,2})?$/ }, 
  	numericality: { greater_than: 0, less_than: 1000}
  validates :menu_category_id, presence: true

  default_scope order: 'menu_items.position'

 	before_save :default_values

	private
    def default_values
      self.position = 
      	position.blank? ? menu_category.menu_items.count + 1 : position
  	end
end
