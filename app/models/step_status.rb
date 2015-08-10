class StepStatus < ActiveRecord::Base
	has_many :steps
	validates :text, presence: true

end
