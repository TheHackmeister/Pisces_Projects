FactoryGirl.define do
  factory :communication_type do
    text "Phone"
    val 1


		factory :communication_type_alt do
			text "Alt Communication"
			val 2
		end
  end
end

