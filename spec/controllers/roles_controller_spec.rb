require 'rails_helper'

RSpec.describe RolesController do
	include_context 'application' # Sets up user, admin, and role
	
	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:title => nil}
	it_behaves_like 'an update controller', {:title => nil}, {:title => "Example Text"}
	it_behaves_like 'a delete controller' 

end


