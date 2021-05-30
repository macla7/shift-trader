class UserGroup < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :invites
  has_many :confirmed, -> { where confirmed: true }, class_name: 'Invite', foreign_key: 'group_id'
  has_many :unconfirmed, -> { where confirmed: false }, class_name: 'Invite', foreign_key: 'group_id'
end
