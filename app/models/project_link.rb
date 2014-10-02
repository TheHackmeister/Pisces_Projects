class ProjectLink < ActiveRecord::Base
  belongs_to :Project
# validates :Project_id, :presence => true
end
