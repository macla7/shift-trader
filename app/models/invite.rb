class Invite < ApplicationRecord
  belongs_to :user_group, foreign_key: 'group_id'
  belongs_to :invitor, class_name: 'User', inverse_of: 'invites'
  belongs_to :invitee, class_name: 'User'

  # Method in here to find the actual non-host on Invite.
  def worker
    host = user_group.host
    if invitor == host
      invitee
    else
      invitor
    end
  end
end
