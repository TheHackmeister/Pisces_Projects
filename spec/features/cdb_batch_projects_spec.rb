############################################
# You must manually create the _alt factory#
############################################

require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe CdbBatchProject, type: :feature do
	include_context 'features'

	it_behaves_like 'a create page'
	it_behaves_like 'a delete page'
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an update page'
end
