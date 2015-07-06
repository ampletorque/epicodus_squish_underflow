class UsersController < ApplicationController

  before_filter :authenticate
  before_filter :admin_only, :except => :show

  def index
    @users = User.all
  end

  def authenticate
    if current_user = User.authenticate("john@john.com", "badpassword1234")
      redirect_to users_path, :id => current_user.id
    else
      redirect_to users_path, :alert => "Not logged in."
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the site!"
      redirect_to "/"
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back
    end
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
