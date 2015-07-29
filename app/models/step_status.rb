class StepStatus < ActiveRecord::Base
	has_many :steps
	validates :text, presence: true

	def to_s
		if text
			text
		else
			"None"
		end
	end
end
