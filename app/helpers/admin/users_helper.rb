module Admin::UsersHelper

  # 
  def user_role_options
    User.roles.map{ |k,v| [k, k] }
  end
  
end
