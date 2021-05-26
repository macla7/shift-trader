class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :requests
  has_many :pending_requests, -> { where accepted: false }, class_name: 'Request', foreign_key: "friend_id"
  has_many :sent_requests, -> { where confirmed: false }, class_name: 'Request', foreign_key: 'user_id'


  # From Omniauth guide
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # Next 3 methods are from request guide.
  def friends
    friends_i_sent_requests = Request.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_requests = Request.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_got_requests + friends_i_sent_requests
    User.where(id: ids)
  end

  # 2.
  def friends_with?(user)
    Request.confirmed_request?(id, user.id)
  end

  # 3.
  def send_request(user)
    requests.create(friend_id: user.id)
  end
  
end
