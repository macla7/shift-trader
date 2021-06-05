module ApplicationHelper
  def nav_buttons
    if user_signed_in?
      # <%#= button_to "Logout", destroy_user_session_path, method: :delete %>
      # <%#= button_to "Link Facebook account", user_facebook_omniauth_authorize_path %>
      # <%#= button_to "Users Search", users_path, method: :get %>
      # <%#= button_to "Workplaces Home", root_path, method: :get %>
    end
  end

  def host
    @user_group.host.id == current_user.id ? "host" : "worker"
  end
end
