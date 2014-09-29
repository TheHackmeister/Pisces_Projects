class CreateProjectLinks < ActiveRecord::Migration
  def change
    create_table :project_links do |t|
      t.references :Project, index: true
      t.integer :sort
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
