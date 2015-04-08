require 'faker'

FactoryGirl.define do
  factory :step_status do |f|
    f.text 'Not Started'
    f.val 1
  end
end
