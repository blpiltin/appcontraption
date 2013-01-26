class CreateGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
      t.string :label
      t.string :icon
      t.text :description
      t.integer :position
      t.integer :user_id
      t.integer :gadget_type_id

      t.timestamps
    end

    add_index :gadgets, [:user_id, :gadget_type_id], unique: true
  end
end
