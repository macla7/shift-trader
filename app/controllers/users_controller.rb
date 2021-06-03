class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :current_user, only: [:verify]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # # GET /users/1/edit
  # def edit
  # end
 
  # # POST /users or /users.json
  # def create
  #   channel = user_params['channel']
  #   @user = User.new(user_params.except('channel', 'displayed_phone_number'))
  # 
  #   respond_to do |format|
  #     if @user.save
  #       start_verification(@user.phone_number, channel)
  #       session[:user_id] = @user.id
  #       format.html { redirect_to verify_url, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1 or /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: "User was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def verify
    if request.post?
      CheckVerificationJob.delay.perform(@current_user.phone_number, params['verification_code'], @current_user.id)
      redirect_to users_url, notice: 'User is being verified.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :phone_number)
    end

end
