class ApplicationController < ActionController::Base
  before_action :http_authorize
  helper_method :current_user, :logged_in?
  
  # return the current logged-in user
  def current_user
    User.find_by_id(session[:user_id]) if session[:user_id]      
  end
  
  # is user logged-in?
  def logged_in?
    !current_user.nil?
  end
  
  private
  
  # authorize normal http requests
  def http_authorize    
    redirect_to login_path, alert: 'Authorization required' if !logged_in? 
  end
  
end
