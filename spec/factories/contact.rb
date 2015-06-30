FactoryGirl.define do
  factory :contact do
    contact_name "Contact Name"
    phone "123-456-7980"
    email "Contact@email.com"
    address "123 Test Lane"
		sequence(:project_id) { 
			if(Project.count == 0) then
				(create :project).id
			else
				Project.find(1).id
			end
		}
  end
end

