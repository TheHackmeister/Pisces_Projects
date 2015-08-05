require 'rails_helper'

RSpec.describe PrioritiesController do
	include_context 'application' # Sets up user, admin, and communication_status
	
	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:text => nil}
	it_behaves_like 'an update controller', {:text => nil}, {:text => "Example Text"}
	it_behaves_like 'a delete controller' 

end


