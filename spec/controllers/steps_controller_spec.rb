require 'rails_helper'

RSpec.describe StepsController do
	include_context 'controllers' # Sets up user, admin
	
	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:action => nil}
	it_behaves_like 'an update controller', {:action => nil}, {:action => "Example Text"}
	it_behaves_like 'a delete controller' 

end
