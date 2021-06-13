class UserGroup < ApplicationRecord
  belongs_to :host, class_name: 'User', inverse_of: 'hosts_groups'

  has_many :invites
  has_many :member_invites, -> { where confirmed: true, accepted: true }, class_name: 'Invite'
  has_many :ask_invites, -> { where confirmed: false, accepted: true }, class_name: 'Invite'

  has_many :members, class_name: 'User', through: :member_invites, source: 'invitee'

  has_many :posts

  validates :host_id, presence: :true
  validates :name, presence: :true, uniqueness: true

  def has_member?(user)
    !members.where(id: user.id).empty?
  end

  def has_ask_invite?(user)
    !ask_invites.where(invitee_id: user.id).empty?
  end
end
