# spec/support/controller_spec_helper.rb
module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(email)
    JsonWebToken.encode(email: email)
  end
  
  # normal header
  def headers
    { "ACCEPT" => "application/json" }    
  end

  # return valid headers
  def headers_with_token(token)
    {
      "Authorization" => token,
      "ACCEPT" => "application/json",
      "Content-Type" => "application/json"
    }
  end

  #
  def response_body
    JSON.parse(response.body)
  end
  
end