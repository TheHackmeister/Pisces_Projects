class Status < ActiveRecord::Base
	include HasToS
  has_many :projects
	validates :text, presence:true
end
