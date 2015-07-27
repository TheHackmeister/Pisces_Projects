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
end
