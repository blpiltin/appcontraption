class App < ActiveRecord::Base
	
  image_accessor :icon
  attr_accessible :address, :latlong, :name, :search_words,
    :icon, :retained_icon, :remove_icon, :description

  belongs_to :app_type
  belongs_to :user
  has_many :gadgets, dependent: :destroy

  validates_uniqueness_of :name, scope: :user_id, \
  	message: "app name must be unique."

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, length: { maximum: 200 }
  validates :search_words, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :user_id, presence: true
  validates :app_type_id, presence: true

end
