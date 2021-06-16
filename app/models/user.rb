class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email, :password, :role
  enum role: {'student': 0, 'teacher': 1}
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  
end