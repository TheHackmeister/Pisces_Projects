class AddToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :notes, :string
    add_column :projects, :customer_notes, :string
    add_column :projects, :stumbling_blocks, :string
    add_column :projects, :soft_deadline, :date
  end
end
