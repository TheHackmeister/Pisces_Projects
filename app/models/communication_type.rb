class CommunicationType < ActiveRecord::Base
	include HasToS
	include ReferenceType
  reference_type :drop_down
  has_many :communications
	validates :text, presence: true

end
