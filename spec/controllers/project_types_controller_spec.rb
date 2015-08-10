require 'rails_helper'

RSpec.describe ProjectTypesController, type: :controller do	
	include_context 'controllers'
	
	it_behaves_like 'an index controller' do
		context 'logged in' do 
			before :each do
				sign_in user
			end

			it 'limits the number of project types to 5 per page' do
				6.times do FactoryGirl.create(:project_type) end
				ProjectType.reindex
				get :index
				expect(assigns(:project_types).count).to eq 5
			end

			it 'sorts the project_types via the sort order variable' do
				6.times do FactoryGirl.create(:project_type) end 
				first = FactoryGirl.create(:project_type, sort: 0)
				ProjectType.reindex
				get :index
				expect(assigns(:project_types).first).to eq first
			end
		end
	end

	it_behaves_like 'a show controller' 
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller' 
	it_behaves_like 'a create controller', {:text => ""}
	it_behaves_like 'an update controller', {:text => ""}, {:text => "Good Text"}
	it_behaves_like 'a delete controller'
	
end
