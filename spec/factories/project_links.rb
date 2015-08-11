FactoryGirl.define do
  factory :project_link do
    sort 0
    name 'Project Link'
    url 'http://ProjectLinkURL'
    notes 'Link Notes'
		sequence(:project_id) {
			if Project.count == 0
				(create :project).id
			else
				Project.first.id
			end
		}


		factory :project_link_alt do
			sort 1
			name 'Alt link'
			url 'alt_url'
			notes 'Alt notes'
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
