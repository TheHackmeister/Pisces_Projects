class AddNotesToProjectLinks < ActiveRecord::Migration
  def change
    add_column :project_links, :notes, :string
  end
end
