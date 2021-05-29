class AddOauthregisteredonlyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :oauth_registered_only, :boolean
  end
end
