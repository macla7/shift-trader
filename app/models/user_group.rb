class UserGroup < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :invites
end
