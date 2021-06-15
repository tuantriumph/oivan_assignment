class Api::V1::AuthenticationController < ApplicationController
  skip_forgery_protection
  skip_before_action :http_authorize
  
  # check email, password and return token
  def login
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      new_token = JsonWebToken.encode(email: user.email)
      render json: { auth_token: new_token }
    else
      render json: { error: 'Can not authenticate this user!' }, status: :unauthorized
    end
  end
    
  private  
  
end