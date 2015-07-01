require 'rails_helper'

RSpec.describe ProjectTypesController do
	describe 'GET #index' do
		context 'user is not logged in' do
			it 'redirects to the login page'
		end
		context 'user is logged in' do
			it 'renders the index template'
			it 'assigns the project types to @project_types'
			it 'limits the number of project types to 5 per page'
			it 'sorts the project_types via the sort order variable'
		end
	end

	describe 'GET #new' do
		context 'user is not logged in' do
			it 'redirects to the login page'
		end
		context 'user is logged in' do
			it 'assigns a new project_type to @project_type'
			it 'renders the :new template'
		end
	end

	describe 'POST #create' do
		context 'user is not logged in' do
			it 'redirects to the login page'
		end
		context 'user is logged in' do
			context 'with valid attributes' do
				it 'saves the new project_type'
				it 'redirects to the project_type'
			end
			context 'with invalid attributes' do
				it 'does not save the new project type'
				it 're-renders the :new template'
				it 'assigns the old project_type to @project_type'
				it 'has a message with the reason for failure in .errors.messages'
			end
		end
	end

	describe 'PUT #update' do
		context 'user is not logged in' do
			it 'redirects the user to the login page' 
		end
		context 'user is logged in' do
			context 'project_type has valid attributes' do
				it 'saves the updated project_type'
				it 'redirects to the project_type'
			end
			context 'project_type has invalid attributes' do
				it 'does not save the updated project_type'
				it 'displays an error message'
				it 're-renders the :edit template'
			end
		end
	end


end
