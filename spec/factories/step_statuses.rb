require 'faker'

FactoryGirl.define do
  factory :step_status do 
    text 'Not Started'
    val 1


		factory :step_status_alt do 
			text 'Alt Text'
			val 2 
		end
	end
end
