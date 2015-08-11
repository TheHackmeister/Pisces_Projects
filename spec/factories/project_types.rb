FactoryGirl.define do
  factory :project_type do
		sequence(:text) { |n| "Project Type " + n.to_s}
		val 1
		sequence(:sort) { |n| n}


		factory :project_type_alt do
			sequence(:text) { |n| "Alt Project Type " + n.to_s}
			val 2
			sequence(:sort) { |n| n}
		end
	end
end
