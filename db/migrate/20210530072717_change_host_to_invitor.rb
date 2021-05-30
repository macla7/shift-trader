class ChangeHostToInvitor < ActiveRecord::Migration[6.1]
  change_table :invites do |t|
    t.rename :host_id, :invitor_id
  end
end
