class ChangeStringFormatInProjects < ActiveRecord::Migration
  def change
    change_column :projects, :notes, :text
    change_column :projects, :customer_notes, :text
    change_column :projects, :stumbling_blocks, :text
  end
end
