def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_app_types
    make_apps
    make_gadget_types
    make_gadgets
    make_menu_categories
    make_menu_items
  end
end

def make_users
  admin = User.create!(name:     "Example Admin",
                       email:    "admin@appcontraption.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  user = User.create!(name:     "Example User",
                       email:    "user@appcontraption.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@appcontraption.com"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  30.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..30]
  followers      = users[3..20]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_app_types
  AppType.create! name: 'Restaurant'
  AppType.create! name: 'Coffeeshop'
  AppType.create! name: 'Bookstore'
end

def make_apps
  users = User.all
  user  = users.second
  1.times do |i|
    app = App.new
    app.name = Faker::Company.name
    app.address = Faker::Address.street_address + '\n' +
      Faker::Address.city +  ', ' + 
      Faker::Address.state + ' ' + Faker::Address.zip_code
    app.search_words = Faker::Lorem.words
    app.description = Faker::Lorem.paragraph
    app.user = user
    app.app_type = AppType.find(i+1)
    app.save
  end

  user = users.third
  3.times do |i|
    app = App.new
    app.name = Faker::Company.name
    app.address = Faker::Address.street_address + '\n' +
      Faker::Address.city +  ', ' + 
      Faker::Address.state + ' ' + Faker::Address.zip_code
    app.search_words = Faker::Lorem.words
    app.description = Faker::Lorem.paragraph
    app.user = user
    app.app_type = AppType.find(i+1)
    app.save
  end
end


def make_gadget_types
  GadgetType.create! name: 'Menu'
  GadgetType.create! name: 'Events'
  GadgetType.create! name: 'Photos'
  GadgetType.create! name: 'Music'
  GadgetType.create! name: 'Contact'
  GadgetType.create! name: 'HomePage'
end

def make_gadgets
  apps = App.all
  app  = apps.first
  1.times do |i|
    gadget = Gadget.new
    gadget.position = i+1
    gadget.app = app
    gadget.gadget_type = GadgetType.find(i+1)
    gadget.save
  end

  app = apps.second
  6.times do |i|
    gadget = Gadget.new
    gadget.position = i+1
    gadget.app = app
    gadget.gadget_type = GadgetType.find(i+1)
    gadget.save
  end
end

def make_menu_categories

  gadgets = Gadget.find_all_by_type "Menu"
  gadget = gadgets.first

  1.times do |i|
    menu_category = MenuCategory.new
    menu_category.name = Faker::Lorem.words[0]
    menu_category.description = Faker::Lorem.paragraph
    menu_category.position = i+1
    menu_category.gadget = gadget
    menu_category.save
  end

  gadget = gadgets.second
  20.times do |i|
    menu_category = MenuCategory.new
    menu_category.name = Faker::Lorem.words[0]
    menu_category.description = Faker::Lorem.paragraph
    menu_category.position = i+1
    menu_category.gadget = gadget
    menu_category.save
  end
end

def make_menu_items

  menu_categories = MenuCategory.all
  menu_category = menu_categories.first

  1.times do |i|
    menu_item = MenuItem.new
    menu_item.name = Faker::Lorem.words
    menu_item.description = Faker::Lorem.paragraph
    menu_item.price = rand_price 0.01, 999.99
    menu_item.position = i+1
    menu_item.menu_category = menu_category
    menu_item.save
  end

  menu_category = menu_categories.second
  20.times do |i|
    menu_item = MenuItem.new
    menu_item.name = Faker::Lorem.words
    menu_item.description = Faker::Lorem.paragraph
    menu_item.price = rand_price 0.01, 999.99
    menu_item.position = i+1
    menu_item.menu_category = menu_category
    menu_item.save
  end

end