class CreateRoleAssignments < ActiveRecord::Migration
  def change
    create_table :role_assignments do |t|
      t.references :user, index: true
      t.references :role, index: true
    end
  end
end
