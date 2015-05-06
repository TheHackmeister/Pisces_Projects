class RoleAssignment < ActiveRecord::Base
  #attr_accessible :user_id, :role_id
  belongs_to :user
  belongs_to :role
  #accepts_nested_attributes_for :role
end
