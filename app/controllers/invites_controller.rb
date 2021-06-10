class InvitesController < ApplicationController
  before_action :set_invite, only: %i[ update destroy ]

  def create
    user_group = UserGroup.find_by(id: params['invite']['user_group_id'])
    invitee = User.find_by(email: params['invite']['email']) if params['invite']['email']

    @invite = current_user.invite_for_group(user_group, invitee)
    if @invite.is_a? String
      redirect_to user_group_path(user_group), notice: "#{@invite}"
    elsif @invite.save
      redirect_to user_group_path(user_group), notice: "Invite Sent!" if invitee
      redirect_to user_group_path(user_group), notice: "Request to join group sent!" unless invitee
    else
      redirect_to user_group_path(user_group), notice: "Unknown Error.."
    end
  end

  def update
    user_group = UserGroup.find_by(id: params['invite']['user_group_id'])

    @invite.confirmed = true
    @invite.accepted = true
    if @invite.update(invite_params)
      redirect_to user_group_path(user_group), notice: 'Request accepted!' if params['host']
      redirect_to user_group_path(user_group), notice: 'Invite accepted!' unless params['host']
    else
      redirect_to user_group_path(user_group), notice: 'Invite failed to accept..'
    end
  end

  def destroy
    name = @invite.invitee.name
    group = @invite.user_group


    @invite.destroy!
    respond_to do |format|
      format.html { redirect_to user_group_path(group.id), notice: "#{name} was kicked." } unless params['leave']
      format.html { redirect_to user_groups_path, notice: "You left #{group.name}" } if params['leave']
      format.json { head :no_content }
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
