class Sample < ActiveRecord::Base
  belongs_to :customer

	validates :pisces_id, :customer, :presence => true
end
