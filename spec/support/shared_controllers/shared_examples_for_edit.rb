RSpec.shared_examples 'an edit controller' do
	context 'not logged it' do
		it 'redirects to the login page' do
			get :edit, id: object.id
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in' do
		before :each do
			sign_in user
			get :edit, id: object.id
		end

		it 'assigns the ' + described_class.controller_name.singularize + ' to @' + described_class.controller_name.singularize do
			expect(assigns(class_single.to_sym)).to eq object
		end

		it 'renders the :edit template' do
			expect(response).to render_template :edit
		end
	end
end
