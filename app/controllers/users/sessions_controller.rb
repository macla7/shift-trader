# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # Devise default method code..
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)

    # Twilio's code example..
    if resource && resource.verified
      session[:user_id] = resource.id
      redirect_to root_url, notice: "Logged in!"
    elsif resource && !resource.phone_number.nil?
      session[:user_id] = resource.id
      redirect_to verify_url, notice: "Your phone number is not verified"
    elsif resource
      session[:user_id] = resource.id
      redirect_to root_url, notice: "Please add a phone number to access more featuers."
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
