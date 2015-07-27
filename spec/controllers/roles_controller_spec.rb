require 'rails_helper'

RSpec.describe RolesController do
	include_context 'application' # Sets up user, admin, and role
	
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:title => nil}
	it_behaves_like 'an update page', {:title => nil}, {:title => "Example Text"}
	it_behaves_like 'a delete page' 

end


