class Question < ApplicationRecord
  validates_presence_of :label
  belongs_to :test
  
  attr_accessor :options, # Option-obj parsed from json_options
                :_options # hash params from form
                
  # validate options                
  validate :valid_options, on: [:create, :update]
  
  #
  before_validation :init_options
  
  #
  after_initialize :init_options  
  
  before_save :store_options
  
  #
  def load_options
    init_options
  end
      
  private
    
  # init options
  def init_options
    self.options = []
    _options_changed = false
    
    logger.debug "Q#{self.id} - INIT"
    logger.debug "    OB: #{self.options ? self.options.size : nil}, #{self._options ? self._options.size : nil}, #{self.json_options ? self.json_options.size : nil}"
    # params from form
    if self._options
      #logger.debug "  LOAD FROM _options"
      self._options.each do |i, raw_option|
        option = Option.new(text: raw_option[:text], correct: raw_option[:correct].to_i == 1)
        option.validate
        self.options << option
      end
      _options_changed = true
    # load from json_options
    elsif self.json_options
      #logger.debug "  LOAD FROM _json_options"
      self.options = JSON.parse(self.json_options).map{|e| Option.new(e)}
    end
        
    # need to update the _json_options attribute whenever _options has data (form update) 
    #    for validation in case question has no change
    store_options if _options_changed    
    logger.debug "    OA: #{self.options ? self.options.size : nil}, #{self._options ? self._options.size : nil}, #{self.json_options ? self.json_options.size : nil}"
  end
  
  # do validation on options
  def valid_options
    valid = true
    has_one_checked = false
    logger.debug "Q#{self.id} OV: #{self.id}: #{self.options ? self.options.size : nil}, #{self._options ? self._options.size : nil}, #{self.json_options ? self.json_options.size : nil}"
    
    self.options.each do |option|
      valid = false if option.invalid?
      has_one_checked = true if option.correct?
    end
    
    errors.add(:options, 'Question must have at least 1 option!') if self.options.empty?
    errors.add(:options, 'Question must have at least 1 correct option!') if !self.options.empty? && !has_one_checked
    errors.add(:options, 'All must have text!') if !valid
    
    logger.debug "    ERROR #{errors.full_messages}"
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
