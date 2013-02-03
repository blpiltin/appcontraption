class FixImageAndThumbnailColumns < ActiveRecord::Migration
  def change
  	remove_column :apps, :splash_name
  	add_column :apps, :splash_url, :string
  	remove_column :apps, :icon_name
  	add_column :apps, :icon_url, :string

  	remove_column :gadgets, :icon_name
  	add_column :gadgets, :icon_url, :string

    add_column :menu_categories, :image_uid, :string
    add_column :menu_categories, :image_url, :string
    add_column :menu_categories, :thumbnail_uid, :string
    add_column :menu_categories, :thumbnail_url, :string

    remove_column :menu_items, :image_name
    add_column :menu_items, :image_url, :string
    add_column :menu_items, :thumbnail_uid, :string
    add_column :menu_items, :thumbnail_url, :string
  end
end
