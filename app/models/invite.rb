class Invite < ApplicationRecord
  belongs_to :user_group
  belongs_to :user
  belongs_to :invitee, :class_name => 'User'

end
