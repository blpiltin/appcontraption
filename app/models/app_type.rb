class AppType < ActiveRecord::Base
	attr_accessible :name

  has_many :apps, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
