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
end


