class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.string :image_uid
      t.string :image_name
      t.decimal :price
      t.integer :position
      t.integer :menu_category_id

      t.timestamps
    end

    add_index :menu_items, [ :name, :menu_category_id ], unique: :true
  end
end
