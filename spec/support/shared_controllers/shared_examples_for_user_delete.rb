RSpec.shared_examples 'a user delete controller' do 

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
		
		it 'deletes the ' + described_class.controller_name.singularize do
			expect(class_model.count).to eq 0
		end

		it 'does not displays an error in the flash' do
			expect(flash[:alert]).to eq nil
		end

		it 'displays a success notice' do
			expect(flash[:notice]).to eq class_single.humanize + ' was successfully destroyed.'
		end

		it 'redirects to the ' + described_class.controller_name + ' page' do
			expect(response).to redirect_to class_model
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
