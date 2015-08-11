FactoryGirl.define do
  # Define a basic devise user.
  factory :role do
    title "userRole"
    val 1


		factory :role_alt do
			title "AltUserRole"
			val 2
		end
	end
end
