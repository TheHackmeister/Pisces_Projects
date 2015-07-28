class FixProjectColmunName < ActiveRecord::Migration
  def change
		remove_index :project_links, :name => 'index_project_links_on_Project_id'
		rename_column :project_links, :Project_id, :project_ida
		rename_column :project_links, :project_ida, :project_id
		add_index :project_links, ["project_id"], :name => 'index_project_links_on_project_id'
  end
end
