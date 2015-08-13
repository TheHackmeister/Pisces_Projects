FactoryGirl.define do
  factory :sample do
		sequence :customer_id do |n| 100 + n end
		sequence :pisces_number do |n| n end
	end
end
