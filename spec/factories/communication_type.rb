FactoryGirl.define do
  factory :communication_type do
		sequence(:text) { |n| "Phone " + n.to_s}
    sequence(:val) { |n| n}


		factory :communication_type_alt do
			text "Alt Communication"
			val 2
		end
  end
end

