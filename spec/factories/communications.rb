FactoryGirl.define do
  factory :communication do
		sequence :summary do |n| 'Communication summary ' + n.to_s end
		sequence :notes do |n| 'Communication notes' + n.to_s end
		sequence :comm_date do |n| (Date.today + n).to_s end
		project_id do (create :project).id end
		communication_type_id do (create :communication_type).id end
		communication_status_id do (create :communication_status).id end
		contact_id do (create :contact, project_id: project_id).id end
	end
end

