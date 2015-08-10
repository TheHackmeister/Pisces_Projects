require 'rails_helper'

RSpec.describe ProjectLinksController do
	include_context 'controllers' # Sets up user, admin, and sample

	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:name => nil}
	it_behaves_like 'an update controller', {:name => ""}, {:name => "Example Name"}
	it_behaves_like 'a user delete controller' 

	it 'has a clean controller'
	it 'has some json tests'
end


