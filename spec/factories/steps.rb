FactoryGirl.define do
  factory :step do 
		sequence :action do |n| 'Step Action' + n.to_s end
		sequence :note do |n| 'Step note' + n.to_s end
		sequence :due do |n| (Date.today + n).to_s end
		step_status_id do (create :step_status).id end
		project_id do (create :project).id end
	end
end
