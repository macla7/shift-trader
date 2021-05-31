class Request < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates  :accepted, exclusion: [nil]

  # Next 4 are slightly modified (in case of no.3 completely new) methods from Request tut
  def self.accepted_request?(id1, id2)
    case1 = !Request.where(user_id: id1, friend_id: id2, accepted: true).empty?
    case2 = !Request.where(user_id: id2, friend_id: id1, accepted: true).empty?
    case1 || case2
  end

  # 2.
  def self.record?(id1, id2)
    case1 = !Request.where(user_id: id1, friend_id: id2).empty?
    case2 = !Request.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end

  # 3. Possibly better off shifting to User model..
  def self.got_any_requests?(id1)
    Request.where(friend_id: id1, accepted: false)
  end

  # 4.
  def self.find_friend_record(id1, id2)
    if Request.where(user_id: id1, friend_id: id2, accepted: true).empty?
      Request.where(user_id: id2, friend_id: id1, accepted: true)[0].id
    else
      Request.where(user_id: id1, friend_id: id2, accepted: true)[0].id
    end
  end

end
