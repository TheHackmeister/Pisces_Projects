require 'faker'

FactoryGirl.define do
  factory :priority do |f|
    f.text 'Urgent'
    f.val 1
  end    
end
