require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe Customer, :type => :feature do
	include_context 'features'

	it 'has customer specs'	
	it 'search should look in customer_id' do
		login_as user
		visit customers_path + '?format=json&search=5D'
		expect(page).to have_content '5 D Tropical, Inc. - Damon Diaz' 
	end

	it 'search should look in customer_name' do
		login_as user
		visit customers_path + '?format=json&search=Pisces'
		expect(page).to have_content 'Pisces Molecular' 
	end

#	it_behaves_like 'a create page'
#	it_behaves_like 'a delete page'
#	it_behaves_like 'an index page'
#	it_behaves_like 'a show page'
#	it_behaves_like 'an update page'
end

