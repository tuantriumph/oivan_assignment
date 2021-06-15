FactoryBot.define do
  
  factory :user do
    name {'Any name'}
  end  
  
  factory :test do    
  end
  
  factory :question do
    test
  end
end

# create some tests
def create_some_tests   
  test_ids = []
  
  FactoryBot.create(:test, name: 'Math test', desc: 'Do the math test') do |test|
    jopts = [{text: '2', correct: true}, {text: '1+1=0', correct: false}, {text: '3', correct: false}]
    FactoryBot.build(:question, label: '1+1=', desc: 'Simple math 1', json_options: jopts.to_json, test: test).save
    
    jopts = [{text: '1', correct: false}, {text: '9', correct: true}, {text: '11', correct: false}]
    FactoryBot.build(:question, label: '10-1=', desc: 'Simple math 2', json_options: jopts.to_json, test: test).save
    
    jopts = [{text: '2', correct: false}, {text: '3', correct: false}, {text: 'unknown', correct: true}]
    FactoryBot.build(:question, label: 'axb=', desc: 'Simple math 3', json_options: jopts.to_json, test: test).save
    
    test_ids << test.id
  end
=begin  
  FactoryBot.create(:test, name: 'Q & A', desc: 'Answer the question') do |test|
    jopts = [{text: 'country', correct: true}, {text: 'place', correct: true}, {text: 'hat', correct: false}]
    FactoryBot.build(:question, label: 'Vietnam is a', desc: 'simple enough', json_options: jopts.to_json, test: test).save
    
    jopts = [{text: 'no', correct: false}, {text: 'yes', correct: true}]
    FactoryBot.build(:question, label: '1 kg dust is equal to 1 kg metal?', desc: 'Simple math 2', json_options: jopts.to_json, test: test).save
    
    jopts = [{text: 'Noooo', correct: true}, {text: 'Yes', correct: true}, {text: 'sometimes', correct: true}]
    FactoryBot.build(:question, label: 'Do you like writing test?', desc: 'Developer', json_options: jopts.to_json, test: test).save
    
    test_ids << test.id
  end    
=end 
  test_ids
end