class StepStatus < ActiveRecord::Base
	include HasToS
	has_many :steps
	validates :text, presence: true

end
