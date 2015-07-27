require 'rails_helper'

RSpec.describe ProjectLinksController do
  let(:link) {FactoryGirl.create(:project_link)}
  let(:admin) {FactoryGirl.create(:user, role_title: 'admin', role_val: '2')}

	describe "Post #delete" do
		before(:each) do link end
		context 'user is not logged in' do
			it 'redirects to the login page' do
				post :destroy, id: link.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "with admin account" do
			before(:each) do
				sign_in admin
				post :destroy, id: link.id
			end

			it 'deletes the link' do
				expect(ProjectLink.count).to eq 0
			end

		end
	end


	include_context 'application' # Sets up user, admin, and sample
	
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:name => nil}
#	it_behaves_like 'an update page', {:name => nil}, {:name => "Example Name"}
#	it_behaves_like 'a delete page' 
	it 'has some create, update, delete, and json tests'
end


