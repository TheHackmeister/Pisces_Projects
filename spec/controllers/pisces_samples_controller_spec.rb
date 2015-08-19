#############################################################################
# You must manually set a validation in the model and for create and update.#
#############################################################################

require 'rails_helper'
# This assumes that we're using FactoryGirl
# That there is a :user factory
# and that there is a factory for pisces_sample. 


RSpec.describe PiscesSamplesController, type: :controller do
	include_context 'controllers' # Sets up user, admin, and PiscesSamples
	
	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
#	it_behaves_like 'an edit controller'
#	it_behaves_like 'a new controller'
#	it_behaves_like 'a create controller', {:text => nil}
#	it_behaves_like 'an update controller', {:text => nil}, {:text => "Example Text"}
#	it_behaves_like 'a delete controller' 
	it 'should not have an edit, new, create, update, or delete page'

end

