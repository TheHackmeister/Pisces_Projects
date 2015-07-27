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
				expect(ProjectType.count).to eq 1
			end

			it 'redirects to the new project_type' do
				expect(current_path).to eq project_type_path ProjectType.first
			end
		end
	end

	context 'views projects by project_type', :js do
		before :each do
			7.times do
				FactoryGirl.create(:project_type)
			end

			ProjectType.reindex
			
			7.times do
				FactoryGirl.create :project, project_type: ProjectType.first
			end

			Project.reindex

			cap_login
			visit project_types_path
		end

		it 'shows 5 project types per page' do
			expect(page).to have_css('.outline', count: 5)
		end
		
		# I'd like to test showing only 5 projects per project type, but there seems to be no good way of doing that without setting the projects to be hidden.
		# Currently, they are hidden by being in the div overflow. 
#		it 'shows only 5 projects per project type' do
# I don't currently have a good way of testing for this. 
#			expect(Project.count).to eq 7
#			expect(Project.first.project_type).to eq ProjectType.first
#			expect(page).to have_css('.project', count: 5, visible: true)	
#		end

		it 'can be clicked to show all projects of a project type' do 
			first(".outline div").click 
			expect(page).to have_css('.outline_expanded', count: 1) 
		end
	end
	
	it 'has a settings link' do
		cap_login
		visit "/settings" 
		click_link 'Project Types'
		expect(current_path).to eq project_types_path
	end
end	
