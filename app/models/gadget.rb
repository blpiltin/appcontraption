class Gadget < ActiveRecord::Base
  attr_accessible :description, :icon, :name

  has_one :gadget_type
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :lookup_id, presence: true

  default_scope order: 'gadgets.position'

end
