class Priority < ActiveRecord::Base
  has_many :projects
	validates :text, presence: true
end
