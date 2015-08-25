class AddIsResultsToProjectLinks < ActiveRecord::Migration
  def change
    add_column :project_links, :is_results, :boolean, default: false
  end
end
