# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_client, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    #super
    build_resource(sign_up_params)
    #me
    channel = sign_up_params['channel']

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        start_verification(resource.phone_number, channel)
        session[:user_id] = @user.id
        redirect_to verify_url
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

    #puts params['user']
    #puts "hi"
    #channel = user_params['channel']
    #@user = User.new(user_params.except('channel'))
#
    #respond_to do |format|
    #  if @user.save
    #    start_verification(@user.phone_number, channel)
    #    session[:user_id] = @user.id
    #    format.html { redirect_to verify_url, notice: 'User was successfully created.' }
    #    format.json { render :show, status: :created, location: @user }
    #  else
    #    format.html { render :new, status: :unprocessable_entity }
    #    format.json { render json: @user.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def set_client
    @client = Twilio::REST::Client.new(Rails.application.credentials.twilio[:ACCOUNT_SID], Rails.application.credentials.twilio[:AUTH_TOKEN])
  end

  def start_verification(to, channel='sms')
    channel = 'sms' unless ['sms', 'voice'].include? channel
    verification = @client.verify.services(Rails.application.credentials.twilio[:VERIFICATION_SID])
                                 .verifications
                                 .create(:to => to, :channel => channel)
    return verification.sid
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :phone_number, :email)
  end
end
