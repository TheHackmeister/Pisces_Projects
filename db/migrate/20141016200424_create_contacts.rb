class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :address
      t.references :project

      t.timestamps
    end
  end
end
