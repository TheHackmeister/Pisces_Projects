RSpec.shared_examples 'a show page' do
	context 'when logged in' do
		before :each do
			login_as user
			visit class_path object
		end
		
		it 'has a show page' do
			expect(current_path).to eq (class_path object)
		end
		
		it 'lists all of the attributes' do
			expect(page).to have_attributes object.attributes
#			has_attributes object.attributes
		end

		it 'has an edit link' do
			expect(page).to have_css 'a', text: 'Edit'
		end

		it 'has a destroy link' do 
			expect(page).to have_css 'a', text: 'Destroy'
		end

		it 'has an index link' do
			expect(page).to have_css 'a', text: class_plural.titleize + ' Index'
		end
	end
end
