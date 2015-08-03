class StepStatus < ActiveRecord::Base
	include HasToS
	include ReferenceType
  reference_type :drop_down
	has_many :steps
	validates :text, presence: true

end
