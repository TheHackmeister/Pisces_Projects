require 'rails_helper'

RSpec.describe StepStatusesController do
	include_context 'application' # Sets up user, admin
	
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:text => nil}
	it_behaves_like 'an update page', {:text => nil}, {:text => "Example Text"}
	it_behaves_like 'a delete page' 

end