require 'rails_helper'

RSpec.describe SamplesController do
	include_context 'application' # Sets up user, admin, and sample
	
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:customer_id => nil}
	it_behaves_like 'an update page', {:customer_id => nil}, {:customer_id => 382}
	it_behaves_like 'a delete page' 
	it 'does not actually delete the sample'

end
