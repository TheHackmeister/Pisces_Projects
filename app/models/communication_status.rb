class CommunicationStatus < ActiveRecord::Base
  has_many :communications
	validates :text, presence: true
end
