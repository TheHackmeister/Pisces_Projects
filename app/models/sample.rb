class Sample < ActiveRecord::Base
	include HasToS
  belongs_to :customer

	validates :pisces_id, :customer, :presence => true
end
