class PiscesDatabase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :pisces_database_production
end

class Customer < PiscesDatabase
  include Filterable
  self.primary_key = :id

  scope :customer_name_search, ->(customer_name) { where('lower(customer_name) LIKE ?', "%#{customer_name.downcase}%")}

#  scope :location, -> (location_id) { where location_id: location_id }
#  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}


  self.table_name = :cst_customer
  has_many :projects
  #alias_attribute :text, :customer_name
  def text
    att = self.attributes.clone#[:customer_name]
    name = "Jdpps"
    att.each do |key, val|
      #next if key != "customer_name"
      name = val
    end
    name = self.attributes["customer_name"]
    #return att['customer_id']
    name[0..name.length - 4]  #name #att['customer_name']#Customer.connection.select_all("SELECT customer_name FROM cst_customer WHERE id = '%#{id}%'")[0]
  end
end

