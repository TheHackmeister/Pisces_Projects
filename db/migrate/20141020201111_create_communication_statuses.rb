class CreateCommunicationStatuses < ActiveRecord::Migration
  def change
    create_table :communication_statuses do |t|
      t.string :text
      t.integer :val

      t.timestamps
    end
  end
end
