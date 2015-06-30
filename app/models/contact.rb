class Contact < ActiveRecord::Base
  include Filterable
  belongs_to :project
  has_many :communications
  scope :contact_name, ->(contact_name) {where('lower(contact_name) LIKE ?', "%#{contact_name.downcase}%")}
  scope :project_id, ->(project_id) {where(:project_id => project_id)}
  #scope :cust_name, ->(c_name) {where c_name}
  validates :contact_name, :presence => true
	
	after_save :reindex_project
	around_destroy :reindex_project

	def reindex_project
		Sunspot.index(project)
		yield
	end
end
