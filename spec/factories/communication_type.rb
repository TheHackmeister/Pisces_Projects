FactoryGirl.define do
  factory :communication_type do
		sequence :text do |n| "Phone " + n.to_s end
		sequence :val do |n| n end
  end
end

