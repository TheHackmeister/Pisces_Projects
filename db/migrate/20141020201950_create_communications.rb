class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.string :summary
      t.text :notes
      t.references :communication_status, index: true
      t.references :communication_type, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
