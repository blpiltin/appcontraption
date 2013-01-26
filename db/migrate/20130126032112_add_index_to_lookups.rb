class AddIndexToLookups < ActiveRecord::Migration
  def change
 		add_index :lookups, [:ac_type, :name], unique: true
 		add_index :lookups, [:ac_type, :name, :code], unique: true
  end
end
