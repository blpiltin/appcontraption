class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :name
      t.text :description
      t.string :icon_uid
      t.string :icon_name
      t.integer :position
      t.integer :gadget_id
      
      t.timestamps
    end

    add_index :menu_categories, [ :name, :gadget_id ], unique: :true
    
  end
end
