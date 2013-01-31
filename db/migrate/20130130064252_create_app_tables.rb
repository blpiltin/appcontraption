class CreateAppTables < ActiveRecord::Migration
  def up
  	create_table :app_types do |t|
      t.string :name

      t.timestamps
    end
    add_index :app_types, :name, unique: true

    create_table :apps do |t|
      t.string :name
      t.string :address
      t.string :latlong
      t.string :search_words
      t.text :description
      t.string :icon_uid
      t.string :icon_name
      t.integer :app_type_id
      t.integer :user_id

      t.timestamps
    end

    add_index :apps, [:name, :user_id], unique: true
  end

  def down
  	drop_table :apps
  	drop_table :app_types
  end
end
