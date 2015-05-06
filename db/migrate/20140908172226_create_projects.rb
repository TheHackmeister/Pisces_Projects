class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.date :started
      t.string :goal
      t.references :customer, index: true
      t.references :priority, index: true
      t.references :status, index: true

      t.timestamps
    end
  end
end
