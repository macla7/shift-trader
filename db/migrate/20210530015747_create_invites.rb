class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :invitee
      t.integer :group
      t.boolean :confirmed, default: :false

      t.timestamps
    end
  end
end
