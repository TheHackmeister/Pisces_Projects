class CdbBatchProject < ActiveRecord::Base
	self.table_name = 'pisces_projects.cdb_batch_projects'
  belongs_to :cd_batch, foreign_key: 'cdb_batch_id', primary_key: 'cd_batch_id', class_name: :CdbBatch
  belongs_to :project
end

