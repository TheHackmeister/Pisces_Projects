require 'faker'
FactoryGirl.define do
  factory :step do |f|
    step_status
    
    f.action 'Step Action'
    f.note 'Step note'
    f.due "10/10/2010"
    

    association :project
  end
end
