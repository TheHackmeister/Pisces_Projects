FactoryGirl.define do
  factory :project_link do
    sort 0
    name 'Project Link'
    url 'http://ProjectLinkURL'
    notes 'Link Notes'
    Project {FactoryGirl.create(:project)}
  end
end
