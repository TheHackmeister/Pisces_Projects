class CdbBatch < PiscesDatabase
	self.table_name = :cdb_batch
	self.primary_key = :cd_batch_id
	has_many :pisces_samples, foreign_key: 'cd_batch_id'
	has_many :cdb_batch_projects
	has_many :projects, through: :cdb_batch_projects

	belongs_to :customer, primary_key: 'customer_id'

	searchable do
		integer :cd_batch_id
		text :customer_id
		text :priority_code
		text :spec_cust_instructions
		text :spec_pisces_instructions
		text :observations_problems
		text :batch_status
	end
	
	def to_s
		cd_batch_id
	end
end

