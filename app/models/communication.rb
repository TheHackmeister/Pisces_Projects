class Communication < ActiveRecord::Base
  belongs_to :communication_status
  belongs_to :communication_type
  belongs_to :project
  belongs_to :contact
  
  validates_associated :communication_status, :communication_type
  validates :summary, :contact, :project, :communication_status, :communication_type, :presence => true
  
  after_validation :init
  after_initialize :init
  
  def init
    self.contact ||= Contact.new
  end
end
