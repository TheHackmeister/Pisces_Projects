FactoryGirl.define do
  factory :communication do
    summary 'Communication summary'
    communication_type
    communication_status
    notes 'Communication notes'
    contact
    project
  end
end

