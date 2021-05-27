# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password]) && user.verified
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    elsif user && user.authenticate(params[:password])
      redirect_to verify_url, notice: "You are not verified"
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
