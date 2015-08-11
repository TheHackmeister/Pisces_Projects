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


		factory :contact_alt do
			contact_name "Alt Contact Name"
			phone "098-765-4321"
			email "AltContact@email.com"
			address "Alt 123 Test Lane"
			sequence(:project_id) { 
				if Project.count < 2
					(create :project).id
				else
					Project.all[1].id
				end
			}
		end
	end
end

