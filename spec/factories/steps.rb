require 'faker'
FactoryGirl.define do
  factory :step do 
		sequence(:step_status_id) {
			if StepStatus.count == 0 
				(create :step_status).id
			else
				StepStatus.first.id
			end
		}
    
    action 'Step Action'
    note 'Step note'
    due "10/10/2010"
    

		sequence(:project_id) {
			if Project.count == 0
				(create :project).id
			else
				Project.first.id
			end
		}

		factory :step_alt do
			action 'Alt Step Action'
			note 'Alt Step note'
			due "08/09/2015"

			sequence(:step_status_id) {
				if StepStatus.count < 2 
					(create :step_status).id
				else
					StepStatus.all[1].id
				end
			}
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
