class ProjectType < ActiveRecord::Base
	has_many :projects
	validates :text, :presence => true

	default_scope { order('sort ASC')}

	searchable do
		text :text
		integer :sort
	end
end
