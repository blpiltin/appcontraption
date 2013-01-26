class CreateLookups < ActiveRecord::Migration
  def change
  	drop_table :lookups
    create_table :lookups do |t|
      t.string :ac_type
      t.string :name
      t.integer :code
      t.integer :position

      t.timestamps
    end
  end
end
