class AddResultsNotesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :results_notes, :text
  end
end
