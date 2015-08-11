class Sample < ActiveRecord::Base
  belongs_to :customer

	validates :pisces_number, :customer, :presence => true
end
