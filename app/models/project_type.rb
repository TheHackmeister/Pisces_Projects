class ProjectType < ActiveRecord::Base
	has_many :projects
	validates :text, :presence => true

	default_scope { order('sort ASC')}

	searchable do
		text :text
		integer :sort
	end
	reference_type_is_not_search true
end
