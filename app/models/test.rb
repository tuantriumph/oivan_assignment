class Test < ApplicationRecord
  validates_presence_of :name, :desc
  has_many :questions, dependent: :destroy
  
  accepts_nested_attributes_for :questions, allow_destroy: true
  
  #def as_json
  #  self.to_json
  #end
end