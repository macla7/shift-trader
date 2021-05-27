class RemoveCountrycodeFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :country_code, :string
  end
end
