class ChangeNameUseridToHostid < ActiveRecord::Migration[6.1]
  change_table :invites do |t|
    t.rename :user_id, :host_id
    t.rename :group, :group_id
  end
end
