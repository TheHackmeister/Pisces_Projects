class CreateStatuses < ActiveRecord::Migration
  def change
    drop_table :statuses
    create_table :statuses do |t|
      t.string :text
      t.integer :val

      t.timestamps
    end
  end
end
