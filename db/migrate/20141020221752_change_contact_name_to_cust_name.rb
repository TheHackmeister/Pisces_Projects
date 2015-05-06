class ChangeContactNameToCustName < ActiveRecord::Migration
  def change
    rename_column :contacts, :name, :contact_name
  end
end
