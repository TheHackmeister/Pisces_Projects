class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.references :customer, index: true
      t.integer :pisces_id

      t.timestamps
    end
  end
end
