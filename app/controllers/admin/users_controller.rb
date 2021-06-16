class Admin::UsersController < ApplicationController
  before_action :user_preload, :only => [:show, :edit, :update, :destroy]
  
  # admin default page
  # list all users
  def index
    @users = User.all
  end
  
  # show user
  def show
    @user = User.find params[:id]
  end

  # new user form
  def new
    @user = User.new
  end

  # create new user
  def create
    @user = User.new user_params
        
    if @user.save
      redirect_to users_path, notice: 'User created successfully!' 
    else
      render :new
    end
  end

  # edit user
  def edit
  end

  # save edited user
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully!' 
    else
      render :edit
    end
  end
  
  # delete user
  def destroy
    if @user != current_user
      @user.destroy
      if @user.destroyed?
        notice = 'User deleted successfully!'
      end
    else
      alert = 'You can not delete your account!'
    end
      
    redirect_to users_path, notice: notice, alert: alert
  end
  
  private
  
  # load user by id
  def user_preload
    @user = User.find params[:id]
  end
  
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end  
end
