RSpec.shared_examples 'a create page' do
	# No need to check when not logged in. Handled by controller specs.
	let(:valid_attributes) {FactoryGirl.attributes_for(described_class.table_name.singularize.to_sym)}

	context 'when logged in', :js do
		before :each do
			login_as user
			valid_attributes
			visit new_class_path
		end

		it 'has a create page' do
			expect(current_path).to eq(new_class_path)
		end
	
		it 'has the same number of inputs as attributes' do
			expect(page).to have_css('div.field', count: valid_attributes.count)
		end

		it 'can be filled in' do
			fill_attributes class_name.to_sym, valid_attributes
			click_button :Save
			expect(described_class.last.attributes).to have_attributes valid_attributes
		end

		it 'gets saved to the database' do
			expect{
			fill_attributes class_name.to_sym, valid_attributes
			click_button :Save}.to change{described_class.count}.by 1
		end

	end
end
