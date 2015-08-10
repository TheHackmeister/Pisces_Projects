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
  end

	factory :project_link_alt, class: :project_link do
		sort 1
		name 'Alt link'
		url 'alt_url'
		notes 'Alt notes'
		sequence(:project_id) {
			if Project.count < 2
				(create :project).id
			else
				Project[1].id
			end
		}
	end
end
