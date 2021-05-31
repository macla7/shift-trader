class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: [:facebook, :create]

  # Original Omniauth basic Log in / Sign up.
  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   
  #   if @user.persisted?
  #     session[:user_id] = @user.id
  #     sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
  #     redirect_to new_user_registration_url
  #   end
  # end

  def facebook
    auth = request.env['omniauth.auth']

    @identity = Identity.find_with_omniauth(auth)
  
    if @identity.nil?
      @identity = Identity.create_with_omniauth(auth)
    end
  
    if signed_in?
      if @identity.user == current_user 
        redirect_to root_url, notice: "Already linked that account!"
      else
        @identity.user = current_user
        @identity.save
        redirect_to root_url, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # Log in
        sign_in_and_redirect @identity.user, event: :authentication
      else 
        # New User
        @user = User.from_omniauth(request.env["omniauth.auth"])
        
        if @user.persisted?
          session[:user_id] = @user.id
          sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
          set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        else
          # Sign-up didn't work, directed to normal registration.
          session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url
        end
      end
    end
  end

  def failure
    redirect_to root_path
  end
end