class ChangeInviteeToInviteeid < ActiveRecord::Migration[6.1]
  change_table :invites do |t|
    t.rename :invitee, :invitee_id
  end
end
