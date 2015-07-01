class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|
      t.string :text
      t.integer :val
      t.integer :sort

      t.timestamps
    end
  end
end
