class UserGroupPresenter < BasePresenter

  presents :user_group

  def group_actions
    if user_group.host.id != h.current_user.id
      if !h.current_user.recieved_invite_from_group(user_group).empty?
        h.button_to "Accept Invite", h.invite_path(h.current_user.my_rec_invites.where(user_group_id: user_group.id).first), method: :put, params: { invite: { user_group_id: user_group.id }}
      elsif user_group.has_member?(h.current_user)
        h.button_to "Leave Group", h.invite_path(h.current_user.find_membership_with_group(user_group)), method: :delete, params: { leave: true }
      elsif user_group.has_ask_invite?(h.current_user)
        h.button_to "Request sent", {}, disabled: true
      else
        h.button_to "Request to Join", h.invites_path, params: { invite: { user_group_id: user_group.id }}
      end
    end
  end

  def user_type
    user_group.host.id == h.current_user.id ? "host" : "worker"
  end

  def kick_rights(member)
    if user_type == 'host'
      h.link_to 'kick', h.invite_path(member.find_membership(user_group, member)), method: :delete
    end
  end
end