class SessionsController < ApplicationController
  skip_before_action :http_authorize, only: [:new, :create, :destroy]
  
  # login page
  def new
  end

  # check user credential and create session
  def create
    user = User.find_by_email(params[:email])
    session[:user_id] = nil
    
    if user && user.authenticate(params[:password])
      if user.teacher?
        session[:user_id] = user.id        
      else
        alert = 'Only teacher can login!'
      end
    else
      alert = 'User not found!'
    end
    
    # teacher can login
    if session[:user_id]
      redirect_to root_path
    else
      redirect_to login_path, alert: alert
    end
  end
  
  # destroy session to logout
  def destroy
    if request.delete?
      session[:user_id] = nil
      redirect_to login_path
    end
  end

end
