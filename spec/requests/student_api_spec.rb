require 'rails_helper'

RSpec.describe 'Student API', type: :request do
  
  before do
    @teacher = FactoryBot.create(:user, email: 'teachera@test.com', password: 'abc', role: 1)
    @student = FactoryBot.create(:user, email: 'student@test.com', password: '123', role: 0)
    @fakeuser = FactoryBot.build(:user, email: 'noemail', password: 'nopassword')
  end
    
  ## authentication specs
  context 'authentication' do
    it "login /w valid account" do
      post "/api/v1/login", 
        params: {email: @student.email, password: @student.password}, 
        headers: headers
      
      #p response.body
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
      expect(response_body).to have_key('auth_token')      
    end    
    
    it "login /w invalid account" do
      post "/api/v1/login", 
        params: {email: @fakeuser.email, password: @fakeuser.password}, 
        headers: headers
      
      #p response
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unauthorized)      
    end        
      
  end
    
  ## tests specs
  context 'student' do    
    before :each do 
      @test_ids = create_some_tests
    end            
    
    context 'with valid user' do
      let(:token) { token_generator(@student.email) }

      it "get all tests" do
        get "/api/v1/student/all_tests", params: {}, headers: headers_with_token(token)
        
        #p response.body
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
        expect(response_body).to be_an_instance_of(Array)
      end
      
      it "get one test" do
        if @test_ids.size > 0
          test_id = @test_ids.first
          get "/api/v1/student/get_test/#{test_id}", params: {}, headers: headers_with_token(token)
          
          #p JSON.parse(response.body)
          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:ok)
          expect(response_body).to be_an_instance_of(Hash)
        end
      end
      
      it "save test result" do
        if @test_ids.size > 0
          test_id = @test_ids.first
          post "/api/v1/student/save_result", 
            params: {},
            headers: headers_with_token(token)
          
          #p response.body
          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:ok)
        end
      end
      
      it "logout" do
        get "/api/v1/student/logout", params: {}, headers: headers_with_token(token)
        
        #p response.body
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
        expect(response_body).to have_key("auth_token")
        expect(response_body['auth_token']).to be_nil
      end

    end
    
    context 'with invalid user' do
      let(:faketoken) { token_generator(@fakeuser.email) }
      
      it "get all tests" do
        get "/api/v1/student/all_tests", params: {}, headers: headers_with_token(faketoken)
        
        #p response.body
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unauthorized)
      end    
  
      it "get one test" do
        if @test_ids.size > 0
          test_id = @test_ids.first
          get "/api/v1/student/get_test/#{test_id}", params: {}, headers: headers_with_token(faketoken)
          
          #p response.body
          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:unauthorized)
        end
      end
      
      it "save test result" do
        if @test_ids.size > 0
          test_id = @test_ids.first
          post "/api/v1/student/save_result", 
            params: {}, 
            headers: headers_with_token(faketoken)

          #p response.body
          expect(response.content_type).to eq("application/json; charset=utf-8")
          expect(response).to have_http_status(:unauthorized)
        end
      end
      
      it "logout" do
        get "/api/v1/student/logout", params: {}, headers: headers_with_token(faketoken)
        
        #p response.body
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unauthorized)
      end
    end        
      
  end        
    
end
