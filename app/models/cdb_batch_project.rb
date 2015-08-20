class CdbBatchProject < ActiveRecord::Base
	self.table_name = 'pisces_projects.cdb_batch_projects'
  belongs_to :cdb_batch, primary_key: 'cd_batch_id'
  belongs_to :project
end

