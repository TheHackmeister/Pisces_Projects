class Communication < ActiveRecord::Base
  belongs_to :communication_status
  belongs_to :communication_type
  belongs_to :project
  belongs_to :contact
  
  validates_associated :communication_status, :communication_type
  validates :contact, :project, :communication_status, :communication_type, :presence => true
end
