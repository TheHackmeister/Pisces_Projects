class ProjectType < ActiveRecord::Base
	include HasToS
	include ReferenceType
  reference_type :drop_down
	has_many :projects
	validates :text, :presence => true

	default_scope { order('sort ASC')}

	searchable do
		text :text
		integer :sort
	end
end
