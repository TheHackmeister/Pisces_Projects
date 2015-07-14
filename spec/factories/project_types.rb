FactoryGirl.define do
  factory :project_type do
		sequence(:text) { |n| "Project Type " + n.to_s}
		val 1
		sequence(:sort) { |n| n}
	end
end
