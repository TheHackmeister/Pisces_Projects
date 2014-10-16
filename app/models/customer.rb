class PiscesDatabase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "pisces_database_production"
end

class Customer < PiscesDatabase
  include Filterable
  self.primary_key = :id

  scope :customer_name, ->(customer_name) { where('lower(customer_name) LIKE ?', "%#{customer_name.downcase}%")}

#  scope :location, -> (location_id) { where location_id: location_id }
#  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}


  self.table_name = :cst_customer
  has_many :projects
end

