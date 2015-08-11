class PiscesIdToPiscesNumber < ActiveRecord::Migration
  def change
		rename_column :samples, :pisces_id, :pisces_number
  end
end
