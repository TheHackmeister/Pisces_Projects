class ProjectLink < ActiveRecord::Base
  belongs_to :Project
  validates :Project_id, :presence => true
  validates :url, :name, :presence => true


  before_save{ |link|
    #This changes FF auto replacement in URLs
    link.url = link.url.gsub("%28", "(").gsub("%29", ")").gsub("%20", " ")
  }
end
