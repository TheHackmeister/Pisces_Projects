require 'rails_helper'

RSpec.describe ProjectLinksController do
	include_context 'application' # Sets up user, admin, and sample

	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:name => nil}
	it_behaves_like 'an update page', {:name => ""}, {:name => "Example Name"}
	it_behaves_like 'a user delete page' 

	it 'has a clean controller'
	it 'has some json tests'
end


