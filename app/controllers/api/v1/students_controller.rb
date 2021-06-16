class Api::V1::StudentsController < ApplicationController
  skip_forgery_protection
  
  # skip normal request authentication
  skip_before_action :http_authorize
  
  # use api authentication
  before_action :api_authorize
  
  attr_reader :current_api_user
  
  # get all tests
  def list
    @tests = Test.all
    render json: @tests.as_json(only: [:id, :name, :desc], include: {:questions => {methods: :options, only: [:label, :desc, :options]}}),
           status: :ok
  end

  # get 1 test
  def show
    @test = Test.find(params[:id])
    if @test
      render json: @test.as_json(only: [:id, :name, :desc], include: {:questions => {methods: :options, only: [:label, :desc, :options]}}), 
             status: :ok
    else
      render json: { error: "Can not find test with ID #{params[:id]}" }, status: :not_found
    end
  end

  # save test result
  def save_test_result
    render json: { message: "Test result can not be saved now." }, status: :ok
  end
  
  # logout
  def logout
    render json: { auth_token: nil }
  end
  
  private
  
  #
  def api_authorize
    @current_api_user ||= nil
    
    #logger.debug request.headers['Authorization']
    
    if request.headers['Authorization'].present?
      auth_header = request.headers['Authorization'].split(' ').last
      @decoded_auth_token ||= JsonWebToken.decode(auth_header)
      @current_api_user ||= User.find_by_email(@decoded_auth_token[:email]) if @decoded_auth_token 
    end
    
    if @current_api_user.nil?
      render json: { error: "This is not a authorized request." }, status: :unauthorized
    end    
  end  
    
end
