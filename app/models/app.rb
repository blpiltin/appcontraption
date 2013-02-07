class App < ActiveRecord::Base
	
  image_accessor :icon
  image_accessor :splash

  attr_accessible :address, :latlong, :name, :search_words, :description,
    :icon, :retained_icon, :remove_icon,
    :splash, :retained_splash, :remove_splash

  belongs_to :app_type
  belongs_to :user
  has_many :gadgets, dependent: :destroy

  validates_uniqueness_of :name, scope: :user_id, \
  	message: "app name must be unique."

  before_save :create_access_token

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, length: { maximum: 200 }
  validates :search_words, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :user_id, presence: true
  validates :app_type_id, presence: true

  def parent
    user
  end

  def as_json(options={})
    super(options.merge(methods: [:icon_url, :splash_url]))
  end

  def icon_url
    icon.remote_url unless icon.blank?
  end

  def splash_url
    splash.remote_url unless splash.blank?
  end

  def type
    app_type.name
  end

  private
    def create_access_token
      self.access_token = SecureRandom.urlsafe_base64 if access_token.blank?
    end

end
