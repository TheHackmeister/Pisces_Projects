class Contact < ActiveRecord::Base
  include Filterable
  belongs_to :project
  has_many :communications
  scope :contact_name, ->(contact_name) {where('lower(contact_name) LIKE ?', "%#{contact_name.downcase}%")}
  #scope :cust_name, ->(c_name) {where c_name}
end
