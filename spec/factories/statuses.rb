require 'faker'

FactoryGirl.define do
  factory :status do 
    text 'Not Started'
    val 1


		factory :status_alt do 
			text 'Alt Text'
			val 2
		end
	end
end
