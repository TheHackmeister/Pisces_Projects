require 'faker'

FactoryGirl.define do
  factory :status do 
		sequence :text do |n| 'Status text' + n.to_s end
		sequence :val do |n| n end
	end
end
