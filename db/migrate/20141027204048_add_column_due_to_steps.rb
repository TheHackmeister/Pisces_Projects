class AddColumnDueToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :due, :date
  end
end
