FactoryGirl.define do
  # Define a basic devise user.
  factory :role do
		sequence :title do |n| 'Role Title' + n.to_s end
		sequence :val do |n| n end
	end
end
