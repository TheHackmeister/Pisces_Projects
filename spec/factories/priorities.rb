require 'faker'

FactoryGirl.define do
  factory :priority do
		sequence :text do |n| 'Priority Text' + n.to_s end
		sequence :val do |n| n end
	end    
end
