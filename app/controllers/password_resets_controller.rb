class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]  #case(1)

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?             #case 3
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)      #case 4
      log_in @user
      flash[:success] = "Password has been reset"
      redirect_to @user
    else
      render 'edit'                                #case 2
    end
  end

  def user_params
    params.require(:user).permit(:password, [:password_confirmation])
  end



  private

  # Before filters

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user

  def valid_user
    unless (@user && @user.activated? &&
        @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Check expiration of reset token

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password has been expired"
      redirect_to new_password_reset_url
    end
  end

end
