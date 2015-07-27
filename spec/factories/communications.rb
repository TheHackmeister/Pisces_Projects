FactoryGirl.define do
  factory :communication do
    summary 'Communication summary'
    notes 'Communication notes'
		sequence(:communication_type_id){
			if CommunicationType 
				(create :communication_type).id
			else
				CommunicationType.first.id
			end
		}
		sequence(:communication_status_id){
			if CommunicationStatus.count == 0
				(create :communication_status).id
			else
				CommunicationStatus.first.id
			end
		}
		sequence(:contact_id){
			if Contact.count == 0 
				(create :contact).id
			else
				Contact.first.id
			end
		}
    sequence(:project_id){
			if Project.count == 0
				(create :project).id
			else
				Project.first.id
			end
		}	
  end
end

