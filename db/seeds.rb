# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed_users
	admin = User.create!(
		name: "Brian L. Piltin",
		email: "blpiltin@gmail.com",
		password: "jesus123",
		password_confirmation: "jesus123")
	admin.toggle!(:admin)
end

def seed_app_types
  AppType.create! name: 'Restaurant'
  # AppType.create! name: 'Sports Bar'
  # AppType.create! name: 'Coffeeshop'
  # AppType.create! name: 'Bookstore'
end

def seed_gadget_types
  GadgetType.create! name: 'Menu'
  # GadgetType.create! name: 'Events'
  # GadgetType.create! name: 'Photos'
  # GadgetType.create! name: 'Music'
  # GadgetType.create! name: 'Contact'
  # GadgetType.create! name: 'HomePage'
end

seed_users
seed_app_types
seed_gadget_types
