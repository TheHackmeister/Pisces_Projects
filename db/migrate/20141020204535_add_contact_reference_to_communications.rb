class AddContactReferenceToCommunications < ActiveRecord::Migration
  def change
    add_column :communications, :contact_id, :integer, :index => true
    add_index :communications, :contact_id
  end
end
