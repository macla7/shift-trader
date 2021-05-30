class InvitesController < ApplicationController
  before_action :set_invite, only: %i[ update destroy ]

  def create
    user_group = UserGroup.find_by(id: params['invite']['group_id'])

    if params['invite']['email']
      invitee = User.find_by(email: params['invite']['email'])
    else
      invitee = user_group.host
    end

    @invite = current_user.send_invite(invitee, user_group)
    
    @invite.save!
    redirect_to user_groups_path(params['invite']['group_id'])
  end

  def update
    @invite.confirmed = true
    if @invite.update(invite_params)
      p @invite
      redirect_to user_groups_path(params['group_id']), notice: 'Invite accepted!'
    else
      redirect_to user_groups_path(params['group_id']), notice: 'Invite failed to accept..'
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:invitee_id, :host_id, :group_id, :confirmed)
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

end
