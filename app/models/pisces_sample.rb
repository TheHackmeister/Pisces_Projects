class PiscesSample < PiscesDatabase
	self.primary_key = :id
	self.table_name = :smp_sample

	belongs_to :customer, primary_key: 'customer_id'

	searchable do
		integer :sample_id
		text :customer_id
		text :form_code
		text :cond_code
		text :public_comments
		text :pcr_comments
		text :gel_comments
		text :private_comments
	end


	def to_s
		sample_id
	end
end

