class UserGroup < ApplicationRecord
  belongs_to :host, class_name: 'User', inverse_of: 'hosts_groups'
  # belongs_to :worker, class_name: 'User', inverse_of: 'in_groups'

  has_many :invites
  
  # Not in use yet (I don't believe).
  has_many :in_group, -> { where confirmed: true, accepted: true }, class_name: 'Invite', foreign_key: 'user_group_id'
end
