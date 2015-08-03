class ProjectLink < ActiveRecord::Base
	include HasToS
	include ReferenceType
  reference_type :drop_down
  belongs_to :project
  validates :project, :url, :name, :presence => true


  before_save{ |link|
    # This changes FF auto replacement in URLs
    link.url = link.url.gsub("%28", "(").gsub("%29", ")").gsub("%20", " ")
		
		# This converts system links that we'd copy, into system links firefox can use.
		if (link.url =~ /^"?[a-zA-Z]:\\/ ) then
			link.url = link.url.sub(/^"/, "").sub(/"$/, "") # Removes quotes
			link.url = 'file:///' + link.url
		end
	}
end

