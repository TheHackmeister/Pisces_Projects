class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :priority
  belongs_to :status
  accepts_nested_attributes_for :customer
  has_many :project_links
  accepts_nested_attributes_for :project_links
end
