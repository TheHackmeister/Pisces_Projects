require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe ProjectType, :type => :feature do
	context 'creates a project_type' do
		context 'when not logged in' do
			it 'redirects to the login page' do
				visit new_project_type_path
				expect(current_path).to eq(new_user_session_path)
			end
		end
		context 'when logged in', :js do
			before(:each) do
				cap_login 
				visit new_project_type_path
				fill_attributes :project_type, FactoryGirl.attributes_for(:project_type)
				click_button :Save
			end

			it 'creates a new project_type' do
				expect(Project.count).to eq 1
			end

			it 'redirects to the new project_type' do
				expect(current_path).to eq project_type_path ProjectType.first
			end
		end
	end

	context 'views projects by project_type' do
		it 'shows 5 project types per page' 

		it 'shows only 5 projects per project type'
		it 'can be clicked to show all projects of a project type'
	end
	
	it 'has a settings link' do
		cap_login
		visit 'settings/'
		expect(current_path).to eq "settings/"
		click_link 'Project Types'
		expect(current_path).to eq project_types_path
	end
end	
