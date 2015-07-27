require 'rails_helper'

RSpec.describe StepsController do
	include_context 'application' # Sets up user, admin
	
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:action => nil}
	it_behaves_like 'an update page', {:action => nil}, {:action => "Example Text"}
	it_behaves_like 'a delete page' 

end
