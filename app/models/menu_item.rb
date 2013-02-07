class MenuItem < ActiveRecord::Base
  image_accessor :image do
    copy_to(:thumbnail) {|a| a.thumb('128x128#') }
  end
  image_accessor :thumbnail

  attr_accessible :name, :description, :price,
    :image, :retained_image, :remove_image,
  	:thumbnail, :retained_thumbnail, :remove_thumbnail

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
  
  def as_json(options={})
    super(options.merge(methods: [:image_url, :thumbnail_url]))
  end

  def image_url
    prefix = $request.protocol + $request.host_with_port
    prefix+image.remote_url unless image.blank?
  end

  def thumbnail_url
    prefix = $request.protocol + $request.host_with_port
    prefix+thumbnail.remote_url unless thumbnail.blank?
  end

	private
    def default_values
      self.position = 
      	position.blank? ? menu_category.menu_items.count + 1 : position
  	end
end
