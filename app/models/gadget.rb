class Gadget < ActiveRecord::Base
  before_save :default_values

  attr_accessible :description, :icon, :label

  belongs_to :gadget_type
  belongs_to :user

  validates_uniqueness_of :gadget_type_id, scope: :user_id, \
    message: "only one of each type of gadget allowed."
  validates :label, length: {maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :icon, length: {maximum: 100 }
  validates :user_id, presence: true
  validates :gadget_type_id, presence: true


  default_scope order: 'gadgets.position'

  def name
    label || (gadget_type && gadget_type.name)
  end

  private
    def default_values
      self.label = label.blank? ? gadget_type.name : label
      self.icon = icon.blank? ? gadget_type.name+'.png' : icon
  	end
  
end
