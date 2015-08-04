RSpec.shared_examples 'an update page' do |invalid_attributes, valid_attributes|
	let(:invalid_attribute) {invalid_attributes.keys.first}
	let(:invalid_value) { invalid_attributes.values.first}
	let(:valid_attribute) { valid_attributes.keys.first}
	let(:valid_value) { valid_attributes.values.first}

	context 'not logged in' do
		it 'redirects to the login page' do
			put :update, id: object.id
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in' do
		before(:each) do 
			sign_in user
		end

		context 'with valid attributes' do
			before :each do
				put :update, id: object.id, class_single.to_sym => {valid_attribute => valid_value}
			end

			it 'saves the updated ' + described_class.controller_name.singularize do
				expect(class_model.last.attributes[valid_attribute.to_s]).to eq valid_value
			end
		
			it 'assigns the updated ' + described_class.controller_name.singularize + ' to @' + described_class.controller_name.singularize do
				expect(assigns(class_single.to_sym)).to eq class_model.find(object.id)
			end

			it 'displays a success notice' do
				expect(flash[:notice]).to eq class_single.humanize + ' was successfully updated.'
			end

			it 'redirects to the ' + described_class.controller_name.singularize do
				expect(response).to redirect_to(class_model.last)
			end
		end

		context 'with an invalid attribute' do
			before :each do
				put :update, id: object.id, class_single.to_sym => {invalid_attribute => invalid_value}
			end

			it 'assigns the non-updated ' + described_class.controller_name.singularize + ' to @' + described_class.controller_name.singularize do
				expect(assigns(class_single.to_sym)).to eq object 
			end

			it 'does not save invalid value to the ' + described_class.controller_name.singularize do
				expect(object.attributes[invalid_attribute.to_s]).to_not eq invalid_value
			end
			
			it 'displays an error message in the flash'  do
				expect(flash[:alert]).to eq class_single.humanize + " could not be updated."
			end
			
			it 're-renders the :edit template' do
				expect(response).to render_template(:edit)
			end
		end
	end
end
