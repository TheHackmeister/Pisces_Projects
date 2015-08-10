require 'rails_helper'

RSpec.describe SamplesController do
	include_context 'controllers' # Sets up user, admin, and sample
	
	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:customer_id => nil}
	it_behaves_like 'an update controller', {:customer_id => nil}, {:customer_id => 382}
	it_behaves_like 'a delete controller' 
	it 'does not actually delete the sample'

end
