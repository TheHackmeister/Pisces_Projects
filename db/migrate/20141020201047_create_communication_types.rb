class CreateCommunicationTypes < ActiveRecord::Migration
  def change
    create_table :communication_types do |t|
      t.string :text
      t.integer :val

      t.timestamps
    end
  end
end
