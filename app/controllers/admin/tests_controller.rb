class Admin::TestsController < ApplicationController
  before_action :xhr_request_check, :only => [:create, :update]
  before_action :preload_test, :only => [:show, :edit, :update, :destroy]

  # list all tests
  def index
    @tests = Test.all
  end

  # GET /admin/tests/1 or /admin/tests/1.json
  def show
  end

  # new test
  def new
    @test = Test.new
  end

  # edit test
  def edit    
  end

  # create new test
  def create
    @test = Test.new(test_params)
        
    respond_to do |format|
      if @test.save
        notice = "Test created successfully!"
        format.js
      else
        format.html { render :new }
      end
    end
    
  end

  # update existing test
  def update        
    respond_to do |format|
      
      if @test.update(test_params)
        notice = "Test updated successfully!"
        format.js 
      else
        format.html { render :edit }
      end
    end
  end

  # delete existing test
  def destroy
    @test.destroy
    if @test.destroyed?
      redirect_to tests_path, notice: "Test was successfully destroyed."      
    end
  end
  
  private
  
  # load test object
  def preload_test
    #logger.debug "PRELOADING..."
    @test = Test.find params[:id]
    #@test.questions.map(&:load_options)
  end

  # Only allow a list of trusted parameters through.
  def test_params
    logger.debug "RAW #{params}"
    if params[:test][:questions_attributes]
      params[:test][:questions_attributes].each{|k, v| v[:_options] ||= []}
    end
    logger.debug "RAW #{params}"
    params.require(:test).permit(:name, :desc, questions_attributes: {})
  end
      
  # Only xhr requests are allowed
  def xhr_request_check
    request.xhr?
  end
    
end
