# invalid_attribute is the attribute that is invalid
# invalid_value is the value that is invalid. 

RSpec.shared_examples 'a create controller' do |invalid_attributes|
	let(:valid_attributes) { FactoryGirl.attributes_for(class_single.to_sym) }
	let(:invalid_attribute) { invalid_attributes.keys.first}
	let(:invalid_value) { invalid_attributes.values.first}

	context 'not logged in' do
		it 'redirects to the login page' do
			post :create, class_single.to_sym => valid_attributes 
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in' do
		before(:each) do 
			sign_in user
		end

		context 'and with valid attributes' do
			it 'saves the ' +  described_class.controller_name.singularize + ' to the database' do
				expect{post :create, class_single.to_sym => valid_attributes}.to change{class_model.count}.by 1
			end

			it 'redirects to the ' + described_class.controller_name.singularize do
				post :create, class_single.to_sym => valid_attributes 
				expect(response).to redirect_to(class_model.last)
			end

			it 'displays a success notice' do
				post :create, class_single.to_sym => valid_attributes
				expect(flash[:notice]).to eq class_single.humanize + ' was successfully created.'
			end

			it 'assigns the newly created ' + described_class.controller_name.singularize + ' to @' + described_class.controller_name.singularize do
				post :create, class_single.to_sym => valid_attributes 
				expect(assigns(class_single.to_sym)).to eq class_model.last
			end
		end

		# This covers what happens when an invalid attribute is found.
		context 'and with an invalid attribute' do
			let(:invalid) {
				FactoryGirl.attributes_for(class_single.to_sym, invalid_attribute => invalid_value) 
			}
			
			it 'does not save the ' + described_class.controller_name.singularize + ' to the database' do
				expect{post :create, class_single.to_sym => invalid}.to change{class_model.count}.by 0
			end

			it 're-renders the :new template' do
				post :create, class_single.to_sym => invalid 
				expect(response).to render_template(:new)
			end

			it 'assigns the old ' + described_class.controller_name.singularize + ' to @' + described_class.controller_name.singularize do
				post :create, class_single.to_sym => invalid 
				expect(assigns(class_single.to_sym).attributes.to_s).to eq FactoryGirl.build(class_single.to_sym, invalid).attributes.to_s
			end

			it 'displays an error message in the flash' do
				post :create, class_single.to_sym => invalid
				expect(flash[:alert]).to eq class_single.humanize + ' could not be created.'
			end
		end
	end
end

