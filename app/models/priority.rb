class Priority < ActiveRecord::Base
	include HasToS
	include ReferenceType
  reference_type :drop_down
  has_many :projects
	validates :text, presence: true
end
