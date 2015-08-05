RSpec.shared_examples 'a json index controller' do
	render_views
	before(:each) do
		request.accept = 'application/json'
	end
	
	it 'that returns in json format' do				
		get :index, :token => user.token, :email => user.email
		expect(response.content_type).to include "application/json"
	end

	it 'throws an error if there is not a token' do
		get :index, :email => user.email
		expect(response.status).to eq 401
	end

	it 'uses tokens to authenticate' do
		get :index, :token => user.token, :email => user.email
		expect(response.status).to eq 200
	end

end
