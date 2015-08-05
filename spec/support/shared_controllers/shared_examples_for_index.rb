RSpec.shared_examples 'an index controller' do
	before(:each) {
		objects	
	}

	let(:objects) { 
		obj = []
		3.times {obj.append FactoryGirl.create(described_class.controller_name.singularize.to_sym) }
		class_model.reindex if class_model.respond_to? :reindex
		obj
	}

	context 'not logged in' do
		it 'redirects to the login page' do
			get :index
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	context 'logged in' do
		before :each do 
			sign_in user 
			get :index
		end

		it 'assigns all ' + described_class.controller_name.pluralize + ' to @' + described_class.controller_name.pluralize do
			expect(assigns(described_class.controller_name.pluralize.to_sym)).to eq class_model.all
		end

		it 'renders the :index template' do
			expect(response).to render_template :index
		end
	end
end
