require 'faker'

FactoryGirl.define do
  factory :priority do
    text 'Urgent'
    val 1


		factory :priority_alt do 
			text 'Alt text'
			val 2
		end    
	end    
end
