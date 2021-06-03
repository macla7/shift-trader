# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)
    channel = sign_up_params['channel']
    resource['phone_number'] = nil if sign_up_params['phone_number'] == ""
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        session[:user_id] = @user.id
        if resource['phone_number'] != nil
          StartVerificationJob.delay.perform(resource.phone_number, channel)
          # start_verification(resource.phone_number, channel) # Original way of doing it.
          redirect_to verify_url
        else
          redirect_to users_path
        end
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
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    channel = params['channel']
    resource.verified = false
    resource_updated = update_resource(resource, account_update_params)
    resource['phone_number'] = nil if sign_up_params['phone_number'] == ""

    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      if resource.phone_number
        StartVerificationJob.delay.perform(resource.phone_number, channel)
        redirect_to verify_url
      else
        redirect_to users_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

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

  protected

  def update_resource(resource, params)
    if resource.oauth_registered_only
      if params[:email] && !params[:password].blank? && params[:password] == params[:password_confirmation]
        resource.name = params[:name]
        resource.email = params[:email]
        resource.phone_number = params[:phone_number]
        logger.info "Updating password"
        resource.password = params[:password]
        resource.oauth_registered_only = false
        if resource.save
          clean_up_passwords(resource)
          return true
        else
          return false
        end
      else
        return false
      end
    else
      resource.update_with_password(params)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_number])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :phone_number, :email)
  end
end
