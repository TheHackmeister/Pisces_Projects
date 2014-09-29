class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :priority
  belongs_to :status
  accepts_nested_attributes_for :customer
end
