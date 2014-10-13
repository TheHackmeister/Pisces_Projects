class Step < ActiveRecord::Base
  belongs_to :step_status
  belongs_to :project
  validates :action, :presence => true
end
