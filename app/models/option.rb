class Option  
  include ActiveModel::Model 
    
  attr_accessor :text, :correct
  
  validates_presence_of :text
  
  #
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  # is this correct option?
  def correct?
    correct == true
  end
  
  #
  def persisted?
    false
  end
  
end