require 'rails_helper'

RSpec.describe TokenController do
	render_views
	let(:user) {FactoryGirl.create(:token_user)}
	#let(:user) {FactoryGirl.create(:user)}
	describe "GET #show" do
		it 'should not respond to html requests.' do
			expect{
				sign_in user
				get :show, :format => :html, :email => user.email, :token => user.token
			}.to raise_error
		end

		context 'take a username and password' do
			it 'displays the user if authenticaiton is successful' do
				get :show, :format => :json, :email => user.email, :password => user.password
				expect(response.status).to eq 200
				expect(assigns(:user)).to eq user
				expect(response.body).to have_content user.token
			end
			it 'displays an error if authentication is unsuccessful' do
				get :show, :format => :json, :email => user.email, :password => "WrongPassword"
				expect(response.status).to eq 401
			end
		end
		context 'takes a username and token' do
			it 'displays the user if authentication is successful' do
				get :show, :format => :json, :email => user.email, :token => user.token
				expect(response.status).to eq  200
				expect(assigns(:user)).to eq user
				expect(response.body).to have_content user.token
			end

			it 'displays an error if authenticaiton is unsuccessful' do
				get :show, :format => :json, :email => user.email, :token => "WrongToken"
				expect(response.status).to eq 401
			end
		end
	end
	describe "GET #update" do
		it 'creates a new token with proper authorization' do
			oldToken = user.token
			get :update, :format=> :json, :email => user.email, :password => user.password
			user.reload
			expect(user.token).not_to eq oldToken
			expect(response.body).to have_content user.token
		end

		it 'displays an error with improper authorization' do
			oldToken = user.token
			get :update, :format=> :json, :email => user.email, :password => "WrongPass"
			expect(user.token).to eq oldToken
			expect(response.status).to eq 401
		end
	end
end
