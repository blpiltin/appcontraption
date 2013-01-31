class Gadget < ActiveRecord::Base
  image_accessor :icon
  attr_accessible :description, :label,
    :icon, :retained_icon, :remove_icon

  belongs_to :gadget_type
  belongs_to :app
  has_many :menu_categories, dependent: :destroy

  validates_uniqueness_of :gadget_type_id, scope: :app_id, \
    message: "only one of each type of gadget allowed per app."
  validates :label, length: {maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :app_id, presence: true
  validates :gadget_type_id, presence: true

  default_scope order: 'gadgets.position'

  before_save :default_values

  def self.find_all_by_type(type_name)
    Gadget.where(gadget_type_id:GadgetType.find_by_name(type_name).id)
  end

  def type
    gadget_type.name
  end
  
  def name
    label || (gadget_type && gadget_type.name)
  end

  private
    def default_values
      self.label = label.blank? ? gadget_type.name : label
      self.position = position.blank? ? app.gadgets.count + 1 : position
  	end
  
end
