require 'faker'

FactoryGirl.define do
  factory :step_status do 
		sequence :text do |n| 'Step text' + n.to_s end
		sequence :val do |n| n end 
	end
end
