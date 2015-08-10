require 'rails_helper'

RSpec.describe CommunicationsController do
	
	include_context 'controllers' # Sets up user, admin, and communication_status
	
	it_behaves_like 'an index controller'
	it_behaves_like 'a show controller'
	it_behaves_like 'an edit controller'
	it_behaves_like 'a new controller'
	it_behaves_like 'a create controller', {:summary => nil}
	it_behaves_like 'an update controller', {:summary => nil}, {:summary => "Example Text"}
	it_behaves_like 'a delete controller' 

	describe "contact managament" do
		before(:each) do 
			sign_in user 
		end

		let(:communication) do 
			FactoryGirl.attributes_for(:communication, contact: nil) #.merge(:contact_email => "test@email.com", :contact_name => "Test Name")
		end

		describe "accepts contact_email and contact_name" do
			it "and creates a contact if one doesn't exist" do
				post :create, :communication => communication, :contact_email => "test@email.com", :contact_name => "Test Name" 
				expect(Communication.count).to eq 1
				expect(Contact.count).to eq 1
				expect(response).to redirect_to(Communication.first)
			end

			it "and uses the contact with the same email if it already exisits" do
				contact = FactoryGirl.create(:contact, email: "test@email.com")
				post :create, :communication => communication , :contact_email => "test@email.com", :contact_name => "Test Name"  
				expect(response).to redirect_to(Communication.first)
				expect(Contact.count).to eq 1
				expect(Communication.first.project.contacts.first).to eq contact
			end
		end

		it "and doesn't use other contacts" do
			contact = FactoryGirl.create(:contact, email: "wrong@email.com")
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

	it 'has a reasonable create controller function (This is just a reminder to look at it)'
	it 'has json create specs' 
end


