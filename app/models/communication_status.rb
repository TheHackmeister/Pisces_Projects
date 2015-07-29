class CommunicationStatus < ActiveRecord::Base
  has_many :communications
	validates :text, presence: true

	def to_s
		text
	end
end
