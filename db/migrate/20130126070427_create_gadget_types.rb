class CreateGadgetTypes < ActiveRecord::Migration
  def change
    create_table :gadget_types do |t|
      t.string :name

      t.timestamps
    end

   	add_index :gadget_types, :name, unique: true
  end
end
