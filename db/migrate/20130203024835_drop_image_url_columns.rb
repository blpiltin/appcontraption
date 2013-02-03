class DropImageUrlColumns < ActiveRecord::Migration
  def change
  	remove_column :apps, :splash_url
  	remove_column :apps, :icon_url
  
  	remove_column :gadgets, :icon_url

    remove_column :menu_categories, :image_url
    remove_column :menu_categories, :thumbnail_url

    remove_column :menu_items, :image_url
    remove_column :menu_items, :thumbnail_url    
  end
end
