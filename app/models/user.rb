class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  # Request
  has_many :requests
  has_many :my_rec_requests, -> { where accepted: false }, class_name: 'Request', foreign_key: "friend_id"
  has_many :my_sent_requests, -> { where accepted: false }, class_name: 'Request', foreign_key: 'user_id'

  # Identity
  has_many :identities, dependent: :destroy

  # Invite
  has_many :my_sent_invites, foreign_key: 'invitor_id', class_name: 'Invite'
  has_many :my_ask_invites, foreign_key: 'invitee_id', class_name: 'Invite'
  has_many :my_rec_invites, -> { where confirmed: true, accepted: false }, class_name: 'Invite', foreign_key: 'invitee_id'

  # UserGroup
  has_many :hosts_groups, class_name: 'UserGroup', foreign_key: 'host_id'
  ### has_many :in_groups, through: :invites, foreign_key: 'invitee_id'
  ### has_many :in_groups, foreign_key: 'host_id'

  # Validations
  validates :name, presence: true, uniqueness: true

  # Come from Twilio example clone, not in use.
  # def to_json(options={})
  #   options[:except] ||= [:verified]
  #   super(options)
  # end

  # Omniauth custom method from user guide
  def self.create_with_omniauth(info)
    create(name: info['name'])
  end

  # From Omniauth guide
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.oauth_registered_only = true
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
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

  # 3 Methods above EXCEPT modified for Invite model

  def invite_for_group(user_group, user = nil)
    return send_invite(user_group, user) if user
    ask_invite(user_group) unless user
  end

  def send_invite(user_group, user)
    return 'in group' if alread_in_group?(user_group, user)
    return 'already requested' if already_requested?(user_group, user)
    return 'already invited' if already_invited?(user_group, user)
    my_sent_invites.new(invitee_id: user.id, user_group_id: user_group.id, confirmed: true)
  end

  def ask_invite(user_group)
    # if my ask invite is pending alread ... Should stop user in view from making error.
    my_ask_invites.new(invitor_id: user_group.host.id, user_group_id: user_group.id, accepted: true)
  end

  def recieved_invite_from_group(group)
    my_rec_invites.where(user_group_id: group.id)
  end

  def already_invited?(user_group, user)
    !Invite.where(user_group_id: user_group.id, invitee_id: user.id, confirmed: true, accepted: false).empty?
  end

  def already_requested?(user_group, user)
    !Invite.where(user_group_id: user_group.id, invitee_id: user.id, accepted: true, confirmed: false).empty?
  end

  def alread_in_group?(user_group, user)
    !Invite.where(user_group_id: user_group.id, invitee_id: user.id, accepted: true, confirmed: true).empty?
  end
end
