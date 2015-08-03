class Sample < ActiveRecord::Base
	include HasToS
	include ReferenceType
  reference_type :search
  belongs_to :customer

	validates :pisces_id, :customer, :presence => true
end
