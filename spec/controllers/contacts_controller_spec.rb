require 'rails_helper'

RSpec.describe ContactsController do
	include_context 'controllers' # Sets up user, admin, and sample

	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:contact_name => nil}
	it_behaves_like 'an update controller', {:contact_name => ""}, {:contact_name => "Example Name"}
	it_behaves_like 'a delete controller' 

	it 'has json index specs'
end


