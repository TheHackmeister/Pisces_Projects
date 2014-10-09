class CreateStepStatuses < ActiveRecord::Migration
  def change
    create_table :step_statuses do |t|
      t.string :text
      t.integer :val

      t.timestamps
    end
  end
end
