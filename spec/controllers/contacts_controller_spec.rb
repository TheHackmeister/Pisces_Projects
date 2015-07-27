require 'rails_helper'

RSpec.describe ContactsController do
	include_context 'application' # Sets up user, admin, and sample

	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:contact_name => nil}
	it_behaves_like 'an update page', {:contact_name => ""}, {:contact_name => "Example Name"}
	it_behaves_like 'a delete page' 

	it 'has json index specs'
end


