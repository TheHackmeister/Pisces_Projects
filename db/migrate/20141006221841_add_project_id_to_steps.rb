class AddProjectIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :project_id, :integer
    add_index :steps, :project_id
  end
end
