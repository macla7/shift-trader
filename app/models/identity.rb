class Identity < ApplicationRecord
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true

  # class methods
  def self.find_with_omniauth(auth)
    find_by(uid: auth['uid'], provider: auth['provider'])
  end

  def self.create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider'])
  end
end
