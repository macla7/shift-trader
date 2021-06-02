class InvitesController < ApplicationController
  before_action :set_invite, only: %i[ update destroy ]

  def create
    user_group = UserGroup.find_by(id: params['invite']['user_group_id'])
    invitee = User.find_by(email: params['invite']['email']) if params['invite']['email']

    @invite = current_user.invite_for_group(user_group, invitee)
    if @invite.is_a? String
      redirect_to user_group_path(user_group), notice: "#{@invite}"
    elsif @invite.save
      redirect_to user_group_path(user_group), notice: "Request Sent!" if invitee
      redirect_to user_group_path(user_group), notice: "Request to join group!" unless invitee
    else
      redirect_to user_group_path(user_group), notice: "Unknown Error.."
    end
  end

  def update
    user_group = UserGroup.find_by(id: params['invite']['user_group_id'])

    @invite.confirmed = true
    @invite.accepted = true
    if @invite.update(invite_params)
      redirect_to user_group_path(user_group), notice: 'Invite accepted!'
    else
      redirect_to user_group_path(user_group), notice: 'Invite failed to accept..'
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:invitee_id, :host_id, :user_group_id, :confirmed)
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

end
