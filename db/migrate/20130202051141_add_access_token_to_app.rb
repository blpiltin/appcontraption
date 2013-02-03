class AddAccessTokenToApp < ActiveRecord::Migration
  def change
    add_column :apps, :access_token, :string
  end
end
