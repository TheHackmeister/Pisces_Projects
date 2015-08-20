class CreateCdbBatchProjects < ActiveRecord::Migration
  def change
    create_table :cdb_batch_projects do |t|
      t.references :cdb_batch, index: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
