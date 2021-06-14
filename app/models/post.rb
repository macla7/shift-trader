class Post < ApplicationRecord
  belongs_to :user
  belongs_to :user_group

  validates :user_id, presence: :true
  validates :user_group_id, presence: :true

  accepts_nested_attributes_for :shift
end
