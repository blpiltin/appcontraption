class CreateGadgetTables < ActiveRecord::Migration
  def up
    create_table :gadget_types do |t|
      t.string :name

      t.timestamps
    end

   	add_index :gadget_types, :name, unique: true

   	create_table :gadgets do |t|
      t.string :label
      t.text :description
			t.string :icon_uid
			t.string :icon_name
      t.integer :position
      t.integer :gadget_type_id
      t.integer :app_id

      t.timestamps
    end

    add_index :gadgets, [:app_id, :gadget_type_id], unique: true

  end

  def down
  	drop_table :gadgets
  	drop_table :gadget_types
  end
end
