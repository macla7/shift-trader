class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :friend_id
      t.boolean :accepted, default: :false

      t.timestamps
    end
  end
end
