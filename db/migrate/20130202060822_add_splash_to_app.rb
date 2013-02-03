class AddSplashToApp < ActiveRecord::Migration
  def change
    add_column :apps, :splash_uid, :string
    add_column :apps, :splash_name, :string
  end
end
