class Message < ActiveRecord::Base
  attr_accessible :body, :email, :name, :subject

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :subject, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 1000 }

 	before_save { |message| message.email = email.downcase }

end
