class AddProjectTypeToProjects < ActiveRecord::Migration
  def change
		add_column :projects, :project_type_id, :integer, references: :project_types
  end
end
