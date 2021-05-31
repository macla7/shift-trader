class AddAcceptedToInvites < ActiveRecord::Migration[6.1]
  change_table :invites do |t|
    t.boolean :accepted, default: :false
    t.rename :group_id, :user_group_id
  end
end
