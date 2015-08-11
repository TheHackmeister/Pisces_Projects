FactoryGirl.define do
  factory :communication_status do
    text "Follow Up"
    val 1

		factory :communication_status_alt do
			text "Alt Text"
			val 2		
		end
  end
end
