class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :priority
  belongs_to :status
  has_many :contacts, :dependent => :destroy
  has_many :project_links, :dependent => :destroy
  has_many :steps, :dependent => :destroy
  has_many :communications, :dependent => :destroy

  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :project_links
  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :communications

  validates :title, :customer, :priority, :status, :presence => true
  validates_associated :customer, :priority, :status, :project_links, :steps, :contacts, :communications
  
  before_save{ |project| project.notes = project.notes.gsub("%28", "(").gsub("%29", ")").gsub("%20", " ")}
end
