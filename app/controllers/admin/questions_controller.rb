class Admin::QuestionsController < ApplicationController  
  before_action :xhr_request_check

  #
  def create
  end
   
  #
  def update
  end
  
  #
  def destroy
  end
  
  #
  def add_option
  end
  
  #
  def update_option
  end
  
  #
  def destroy_option
  end
  
  private
  # Only xhr requests are allowed
  def xhr_request_check
    request.xhr?
  end
  
end