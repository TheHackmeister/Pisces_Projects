require 'faker'
FactoryGirl.define do
  factory :project do |f|
    transient do
      #Sort by step?
      step_due '10/10/2010'
      step_action 'Action'
      multiple_projects false
    end
		project_type_id  {
			if ProjectType.count == 0 
				FactoryGirl.create(:project_type).id	
			else 
				ProjectType.first.id	
			end
		}
    started '11/01/2010'
    sequence(:goal) { |n| "Project Goal " + n.to_s }
    customer_id 381 # Should be Pisces Molecular

    sequence(:priority_id) { |n| 
      if(Priority.count == 0) then 
        FactoryGirl.create(:priority, text: 'Urgent', val: 1)
        FactoryGirl.create(:priority, text: 'Medium', val: 2)
        FactoryGirl.create(:priority, text: 'Low', val: 3)
      end
      
      if !multiple_projects then
        1
      else 
        (n%3)+ 1  
      end      
    }
    status_id {if Status.count == 0 then FactoryGirl.create(:status).id else 1 end}
    sequence(:title) { |n| "Title " + n.to_s }
    notes "Notes"
    customer_notes "Customer Notes"
    stumbling_blocks "Stumbling Blocks"
    #Sort by soft deadline.
    #soft_deadline "10/13/2010"
    sequence(:soft_deadline) { |n| Date.today() + n.days}
    #soft_deadline "10/10/2015" #This is the wrong date format.  
   
    factory :project_with_step do 
      after(:create) do |project, eval|
        FactoryGirl.create(:step, project: project, due: eval.step_due, action: eval.step_action)
        project.reload
      end
    end
  end
end
