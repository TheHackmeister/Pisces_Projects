RSpec.shared_examples 'a new controller' do
	let(:object) { FactoryGirl.create(described_class.controller_name.singularize.to_sym) }

	context 'not logged in' do
		it 'redirects to the login page' do
			get :new
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in' do
		before(:each) do 
			sign_in user
			get :new
		end

		it 'assigns a new ' + described_class.controller_name.singularize + 'to @' + described_class.controller_name.singularize do
			expect(assigns(described_class.controller_name.singularize.to_sym).new_record?).to eq true
		end

		it "renders the :new template" do
			expect(response).to render_template(:new)
		end 
	end
end

