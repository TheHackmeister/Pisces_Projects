class AddCommDateToCommunication < ActiveRecord::Migration
  def change
    add_column :communications, :comm_date, :date
  end
end
