class Invite < ApplicationRecord
  belongs_to :user_group, foreign_key: 'user_group_id'
  belongs_to :invitor, class_name: 'User', inverse_of: 'my_sent_invites'
  belongs_to :invitee, class_name: 'User', inverse_of: 'my_ask_invites'

  scope :ask_invites, -> (user_group) { where("user_group_id = ?", user_group.id).where(confirmed: false, accepted: true)}
  
  # Given an invite, find the actual non-host on Invite.
  def worker
    host = user_group.host
    if invitor == host
      invitee
    else
      invitor
    end
  end

  # Example of class method that replicates the above scope.
  # def self.self_invited(user_group)
  #   where(invitee_id: user_group.host_id, confirmed: false)
  # end
end
