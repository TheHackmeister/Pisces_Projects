class Step < ActiveRecord::Base
	include HasToS
  include RankedModel
	include ReferenceType
  reference_type :drop_down
  ranks :val
  
  belongs_to :step_status
  belongs_to :project
  validates :action, :project, :presence => true
  
  
  default_scope { order('val DESC') }
  
  #after_initialize do
  before_save do
    if new_record?
      self.step_status_id ||= StepStatus.all.first.id;  
    end
  end
  
end
