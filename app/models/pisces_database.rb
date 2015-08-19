class PiscesDatabase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :pisces_database_production
end
