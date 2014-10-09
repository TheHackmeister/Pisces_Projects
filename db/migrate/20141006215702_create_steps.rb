class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :action
      t.text :note
      t.integer :val
      t.references :step_status, index: true

      t.timestamps
    end
  end
end
