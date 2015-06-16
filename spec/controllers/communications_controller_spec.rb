require 'rails_helper'

RSpec.describe CommunicationsController do
  let(:admin) {FactoryGirl.create(:user, role_title: 'admin', role_val: '2')}
	
	describe "POST #create" do
		before(:each) do 
			sign_in admin 
			FactoryGirl.create(:communication_status)
			FactoryGirl.create(:communication_type)
			FactoryGirl.create(:project)
		end

		let(:communication) do 
			FactoryGirl.attributes_for(:communication, :communication_status_id => 1, :communication_type_id => 1, :project_id => 1) #.merge(:contact_email => "test@email.com", :contact_name => "Test Name")
		end

		describe "accepts contact_email and contact_name" do
			it "and creates a contact if one doesn't exist" do
				post :create, :communication => communication, :contact_email => "test@email.com", :contact_name => "Test Name" 
				expect(Communication.count).to eq 1
				expect(Contact.count).to eq 1
				expect(response).to redirect_to(Communication.first)
			end

			it "and uses the contact with the same email if it already exisits" do
				contact = FactoryGirl.create(:contact, email: "test@email.com", project_id: 1)
				post :create, :communication => communication , :contact_email => "test@email.com", :contact_name => "Test Name"  
				expect(response).to redirect_to(Communication.first)
				expect(Contact.count).to eq 1
				expect(Communication.first.project.contacts.first).to eq contact
			end
		end

		it "and doesn't use other contacts" do
			contact = FactoryGirl.create(:contact, email: "wrong@email.com", project_id: 1)
			post :create, :communication => communication, :contact_email => "test@email.com", :contact_name => "Test Name" 
			expect(Communication.first.contact.email).to eq "test@email.com"
			expect(Contact.count).to eq 2
			expect(Communication.count).to eq 1
		end

		it "creates a new communication" do
			contact = FactoryGirl.create(:contact)
			post :create, :communication => communication.merge(:contact_id => 1).except(:contact_email, :contact_name, :contact) 
			expect(response).to redirect_to(Communication.first)
		end
	end

	describe "CSRF Token checking" do
		before(:each) do ActionController::Base.allow_forgery_protection = true end
		after(:each) do ActionController::Base.allow_forgery_protection = false end
		let(:user) do FactoryGirl.create(:token_user) end
		let(:communication) {FactoryGirl.build :communication}

		it "is disabled for JSON requests" do
			request.accept = "application/json"
			post :create, {:email => user.email, :token => user.token}.merge(:communication => communication.attributes)
			expect(response.status).to eq 201
		end

		it "is enabled for normal requests" do
			expect {post :create, :communication => communication.attributes}.to raise_error
		end
	end
end


