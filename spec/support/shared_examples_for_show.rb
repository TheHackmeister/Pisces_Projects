RSpec.shared_examples 'a show page' do
	let(:object) { FactoryGirl.create(described_class.controller_name.singularize.to_sym) }

	context 'not logged in' do
		it 'redirects to the login page' do
			get :show, id: object
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in' do
		before(:each) do 
			sign_in user
			get :show, id: object
		end

		it 'assigns the requested ' + described_class.controller_name + 'to @' + described_class.controller_name do
			expect(assigns(described_class.controller_name.singularize.to_sym)).to eq(object)
		end

		it "renders the :show template" do
			expect(response).to render_template(:show)
		end 
	end
end

