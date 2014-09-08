class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.string :text
      t.integer :val

      t.timestamps
    end
  end
end
