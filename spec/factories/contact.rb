FactoryGirl.define do
  factory :contact do
		sequence :contact_name do |n| 'Contact Name' + n.to_s end
		sequence :phone do |n| '123-456-7980' + n.to_s end
		sequence :email do |n| 'Contact' + n.to_s + '@email.com' end
		sequence :address do |n| '123 Test Lane' + n.to_s end

		project_id do (create :project).id end
	end
end

