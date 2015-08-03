class CommunicationType < ActiveRecord::Base
	include HasToS
  has_many :communications
	validates :text, presence: true

end
