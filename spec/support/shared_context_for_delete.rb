RSpec.shared_examples 'a delete page' do 

	context 'not logged in' do
		it 'redirects to the login page' do
			post :destroy, id: object.id
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in as a user' do
		before :each do
			sign_in user
			post :destroy, id: object.id
		end
		
		it 'does not delete the ' + described_class.controller_name.singularize do
			expect(class_model.count).to eq 1
		end

		it 'displays an error in the flash' do
			expect(flash[:alert]).to eq 'You are not authorized to access this page.'
		end

		it 're-renders the edit page' do
			expect(response).to render_template(:edit)
		end

		it 'assigns the ' + described_class.controller_name.singularize do
			expect(assigns(class_single.to_sym)).to eq object
		end
	end

	context 'logged in as an admin' do
		before :each do
			sign_in admin
			post :destroy, id: object.id
		end

		it 'deletes the ' + described_class.controller_name.singularize do
			expect(class_model.count).to eq 0
		end

		it 'redirects to the ' + described_class.controller_name + ' page' do
			expect(response).to redirect_to class_model
		end
	end
end
