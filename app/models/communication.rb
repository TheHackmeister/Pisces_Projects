class Communication < ActiveRecord::Base
	include HasToS
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

	def create_contact(email, name) 
		# There isn't a contact with that email. 
		if(self.project.contacts.find_by_email(email) == nil)  
			self.contact = Contact.create(project_id: self.project.id, email: email, contact_name: name)
		else #Otherwise, use that email. 
			self.contact = self.project.contacts.find_by_email(email)
		end	
	end
end
