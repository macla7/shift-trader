class ChangeOauthregisteredonlyToDefaultTrue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :oauth_registered_only, false
  end
end
