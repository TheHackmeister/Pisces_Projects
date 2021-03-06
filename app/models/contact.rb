class Contact < ActiveRecord::Base
  include Filterable
  belongs_to :project
  has_many :communications
  scope :contact_name, ->(contact_name) {where('lower(contact_name) LIKE ?', "%#{contact_name.downcase}%")}
  scope :project_id, ->(project_id) {where(:project_id => project_id)}
  #scope :cust_name, ->(c_name) {where c_name}
  validates :contact_name, :presence => true
	
	after_save :reindex_project
	around_destroy :reindex_deleted_contact

	def reindex_project
		Sunspot.index(project)
	end

	def reindex_deleted_contact
		reindex_project
		yield
	end

	def to_s
		self.contact_name.to_s 
	end
end
