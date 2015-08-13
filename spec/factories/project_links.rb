FactoryGirl.define do
  factory :project_link do
		sequence :name do |n| 'Project Link' + n.to_s end
		sequence :url do |n| 'http://ProjectLinkURL' + n.to_s end
		sequence :notes do |n| 'Link Notes' + n.to_s end
		sequence :sort do |n| n end

		project_id do (create :project).id end
	end
end
