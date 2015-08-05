require 'rails_helper'
 #include Devise::TestHelpers

RSpec.describe ProjectsController do
=begin
	let(:user) {FactoryGirl.create(:user)}
   let(:project) {FactoryGirl.create(:project)}
   let(:admin) {FactoryGirl.create(:user, role_title: 'admin', role_val: '2')}
=end 
	include_context 'application' # Sets up user, admin, and sample

	it_behaves_like 'an index controller' do
		context 'searching' do
			before(:each) do
				sign_in user
				27.times do FactoryGirl.create(:project, multiple_projects: true) end
				Project.reindex
				get :index
			end

			it 'sorts the projects' do
				expect(Project.count).to eq 30 # 27 from seach, 3 from being an index page. 
				array = Project.all
				array = array.sort_by {|el| [el.priority_val, el.id]}
				array = array[0..24]
				expect(assigns(:projects)).to eq(array)
			end

			it 'can display a next page' do
				get :index, :page => 2 
				expect(assigns(:projects).count).to eq 5 # 2 from 27- 25, 3 that are created for being an index page.	       
			end

			it 'paginates projects' do
				expect(assigns(:projects).count).to eq(25)
			end

			it 'test the sort options coming in' do
				get :index, sort: 'title_desc'
				array = Project.all
				array = array.sort_by {|el| [el.title, el.id]}.reverse
				array = array[0..24]
				expect(assigns(:projects)).to eq(array)
			end
		end
	end
	
	it_behaves_like 'a json index controller' do
		context 'when signed in' do
			before(:each) do 
				sign_in user
			end

			it 'that returns projects' do
				27.times do FactoryGirl.create(:project, multiple_projects: true) end
				Project.reindex
				get :index 
				json = JSON.parse(response.body)
				expect(json).to have_content "Title" 
			end				 																

			it 'that can search for a title' do
				FactoryGirl.create(:project, :title => "FunGuy")
				FactoryGirl.create(:project, :title => "Testing")
				FactoryGirl.create(:project, :title => "Nonsense")

				Project.reindex
				get :index, :q => "fun"
				expect(JSON.parse(response.body).length).to eq 1
			end
		end
	end

		#	it_behaves_like 'a show controller'
		#	it_behaves_like 'an edit controller'
		#	it_behaves_like 'a new controller'
		#	it_behaves_like 'a create controller', {:customer_id => nil}
		#	it_behaves_like 'an update controller', {:customer_id => nil}, {:customer_id => 382}
		#	it_behaves_like 'a delete controller' 

=begin
	 describe "GET #index" do 

	 end

	 describe "GET #show" do      
		 context 'user is not logged in' do
			 it 'redirects to the login page' do
				 get :show, id: project
				 expect(response).to redirect_to(new_user_session_path)
			 end
		 end

		 it "assigns the requested project to @project" do
			 sign_in user
			 get :show, id: project
			 expect(assigns(:project)).to eq(project)
		 end

		 it "renders the :show template" do
			sign_in user
			get :show, id: project
			expect(response).to render_template(:show)
		 end 
	 end 

	 describe "GET #new" do 
		 context 'user is not logged in' do
			 it 'redirects to the login page' do
				 get :new
				 expect(response).to redirect_to(new_user_session_path)
			 end
		 end

		 context 'user is signed in' do
			 before(:each) do 
				 sign_in user
				 get :new 
			 end

			 it "assigns a new project to @project" do
				 expect(assigns(:project).new_record?).to eql(true)
			 end

			 it "renders the :new template" do
				 expect(response).to render_template(:new)
			 end
		 end
	 end 

	 describe "POST #create" do 
		 context 'user is not logged in' do
			 it 'redirects to the login page' do
				 post :create
				 expect(response).to redirect_to(new_user_session_path)
			 end
		 end

		 context 'user is logged in' do
			 before(:each) do
				 sign_in user 
			 end

			 context "with valid attributes" do 
				 let(:project) {
					 FactoryGirl.attributes_for(:project)}                   
				 it "saves the new project in the database" do

					 expect{post :create, project: project}.to change(Project,:count).by(1)
				 end

				 it "redirects to the project" do
					 post :create, project: project
					 expect(response).to redirect_to(Project.last)
				 end
			 end 

			 context "with invalid attributes" do
				 before(:each) do
					 sign_in user
				 end 
				 let(:project) {FactoryGirl.attributes_for(:project, status: nil)}

				 it "does not save the new project in the database" do
					 expect{post :create, project: project}.to change(Project, :count).by(0)
				 end

				 it "re-renders the :new template" do
					 post :create, project: project
					 expect(response).to render_template(:new)           
				 end

				 it 'assigns the old project to @project' do
					 post :create, project: project
					 expect(assigns(:project).title).to eq(project[:title])
				 end

				 it 'has a message with the reason for failure in .erros.messages' do
					 post :create, project: project
					 expect(assigns(:project).errors.messages).to eq({:status=>["can't be blank"]})
				 end
			 end
		 end 
	 end 

	 describe "PUT #update" do 
		 context 'user is not logged in' do
			 it 'redirects to the login page' do
				 put :update, id: project.id 
				 expect(response).to redirect_to(new_user_session_path)
			 end
		 end

		 context  'user is logged in' do 
			 before(:each) do sign_in user end

			 context "with valid attributes" do 
				 it "saves the updated project data to the database" do 
					 project.title = "New Title"
					 put :update, id: project.id, project: project.attributes
					 expect(Project.first.attributes.to_s).to eq(project.attributes.to_s)
				 end
				 it "redirects to the project" do
					 project.title = "New Ttitle"
					 put :update, id: project.id, project: project.attributes
					 expect(response).to redirect_to(project)
				 end 
			 end 

			 context "with invalid attributes" do
				 before(:each) do
					 project.title = ""
					 put :update, id: project.id, project: project.attributes
				 end

				 it "does not save the updated project data to the database" do
					 expect(Project.first.title).to_not eq(project.title)
				 end
				 it 'displays an error message in the flash' do
					 expect(flash[:alert]).to eq(["Title can't be blank"])
				 end  
				 it "re-renders the :edit template" do
					 expect(response).to render_template(:edit)
				 end
			 end
		 end 
	 end 

	 describe "Post #delete" do
		 before(:each) do
			 project
		 end

		 context 'user is not logged in' do
			 it 'redirects to the login page' do
				 post :destroy, id: project.id
				 expect(response).to redirect_to(new_user_session_path) 
			 end
		 end

		 context "with admin account" do
			 before(:each) do
				 sign_in admin
				 post :destroy, id: project.id
			 end

			 it 'deletes the project' do
				 expect(Project.count).to eq(0)
			 end
			 it 'redirects to the projects index page' do
				 expect(response).to redirect_to(projects_path)
			 end
		 end

		 context 'without admin accout' do
			 before(:each) do
				 sign_in user
				 post :destroy, id: project.id
			 end
			 it 'does not delete the project' do  
				 expect(Project.count).to eq(1)
			 end

			 it 'displays an error in the flash' do
				 expect(flash[:alert]).to eq("You are not authorized to access this page.")
			 end
			 it 're-renders the edit page' do
				 expect(response).to render_template(:edit)
			 end
		 end     
	 end

=end
	end
