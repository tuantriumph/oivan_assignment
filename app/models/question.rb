class Question < ApplicationRecord
  validates_presence_of :label
  #has_and_belongs_to_many :tests
  belongs_to :test
  
  attr_accessor :options, 
                :_options # hash params from form
  validate :valid_options, on: [:create, :update]
  
  #
  before_validation :init_options
  after_initialize :init_options  
  before_save :store_options
  
  #
  def load_options
    init_options
  end
      
  private
  
  # init options
  def init_options
    real_options = []
    _options_changed = false
    
    logger.debug "B-INIT #{self.options}, #{self._options}, #{self.json_options}"
    # params from form
    if self._options
      self._options.each do |i, raw_option|
        option = Option.new(text: raw_option[:text], correct: raw_option[:correct].to_i == 1)
        option.validate
        real_options << option
      end
      
      self._options = [] # clear the params
      _options_changed = true
    # load from json_options
    elsif self.json_options
      real_options = JSON.parse(self.json_options).map{|e| Option.new(e)}
    end
        
    self.options = real_options
    store_options if _options_changed
    logger.debug "A-INIT #{self.options}, #{self._options}, #{self.json_options}"
  end
  
  # do validation on options
  def valid_options
    valid = true
    has_one_checked = false
    logger.debug "VALID #{self.options}, #{options}, #{self.json_options}"
    self.options.each do |option|
      valid = false if option.invalid?
      has_one_checked = true if option.correct?
    end
    
    errors.add(:options, 'Question must have at least 1 option!') if self.options.empty?
    errors.add(:options, 'Question must have at least 1 correct option!') if !self.options.empty? && !has_one_checked
    errors.add(:options, 'All must have text!') if !valid
    
    logger.debug "ERROR #{errors.inspect}"
  end
  
  # store options as json
  def store_options
    pure_options = []
    self.options.each do |o|
      pure_options << {'text' => o.text, 'correct' => o.correct}
    end
    
    self.json_options = pure_options.to_json
  end

  
end
