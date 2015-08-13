FactoryGirl.define do
  factory :communication_status do
		sequence :text do |n| 'Text' + n.to_s end
		sequence :val do |n| n end
  end
end
