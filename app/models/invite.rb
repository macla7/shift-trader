class Invite < ApplicationRecord
  belongs_to :user_group, foreign_key: 'user_group_id'
  belongs_to :invitor, class_name: 'User', inverse_of: 'my_sent_invites'
  belongs_to :invitee, class_name: 'User', inverse_of: 'my_ask_invites'
  # belongs_to :member,-> { where accepted: true, confirmed: true}, class_name: 'User'
  
  # Given an invite, find the actual non-host on Invite.
  def worker
    host = user_group.host
    if invitor == host
      invitee
    else
      invitor
    end
  end

  def to_partial_path
    'invite/member'
  end

  # Example of class method that replicates the above scope.
  # def self.self_invited(user_group)
  #   where(invitee_id: user_group.host_id, confirmed: false)
  # end
end
