FactoryGirl.define do
  factory :project_type do
		sequence :text do |n| "Project Type " + n.to_s end
		sequence :val do |n| n end
		sequence :sort do |n| n end
	end
end
