class UserGroup < ApplicationRecord
  belongs_to :host, class_name: 'User', inverse_of: 'hosts_groups'
  # belongs_to :worker, class_name: 'User', inverse_of: 'in_groups'

  has_many :invites
  
  has_many :members, class_name: 'User', through: :invites, source: 'invitee'
  has_many :ask_invites, -> { where confirmed: false, accepted: true }, class_name: 'Invite', foreign_key: 'user_group_id'


  def has_member?(user)
    !members.where(invitee_id: user.id).empty?
  end
end
