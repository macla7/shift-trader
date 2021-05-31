class InvitesController < ApplicationController
  before_action :set_invite, only: %i[ update destroy ]

  def create
    user_group = UserGroup.find_by(id: params['invite']['user_group_id'])

    if params['invite']['email']
      # If proper invite
      invitee = User.find_by(email: params['invite']['email'])
      # if they've already asked then ...
      # if invite already sent to them ...
      @invite = current_user.send_invite(invitee, user_group)
      if @invite.save
        redirect_to user_group_path(user_group), notice: "Request Sent!"
      else
        redirect_to user_group_path(user_group), notice: "Error, couldn't ask to be in group.."
      end
    else
      # If asked for invite
      invitee = user_group.host
      # if already in group..
      # if my ask invite is pending alread ...
      @invite = current_user.ask_invite(user_group)
      if @invite.save
        redirect_to user_group_path(user_group), notice: "Request to join group!"
      else
        redirect_to user_group_path(user_group), notice: "Error, couldn't ask to be in group.."
      end
    end

    # if !Invite.self_invited(user_group).where(invitor_id: invitee.id).empty? && params['invite']['email']
    #   # Maybe some day, just accept this request straight up.
    #   redirect_to user_group_path(user_group), notice: "They've already requested to join!"
    # elsif !Invite.invited(user_group).where(invitee_id: invitee.id).empty?
    #   redirect_to user_group_path(user_group), notice: "Request Pending!"
    # else
    #   @invite = current_user.send_invite(invitee, user_group).save!
    #   redirect_to user_group_path(user_group), notice: "Request Sent!"
    # end

  end

  def update
    user_group = UserGroup.find_by(id: params['invite']['user_group_id'])

    @invite.confirmed = true
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
