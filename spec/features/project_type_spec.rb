require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe ProjectType, :type => :feature do
	context 'creates a project_type' do
		context 'when not logged in' do
			it 'redirects to the login page'
		end
		context 'when logged in' do
			it 'creates a new project_type'
			it 'redirects to the new project_type'
		end
	end

	context 'views projects by project_type' do
		it 'shows 5 project types per page'
		it 'shows only 5 projects per project type'
		it 'can be clicked to show all projects of a project type'
	end
	
end	
