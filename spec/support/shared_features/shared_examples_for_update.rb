RSpec.shared_examples 'an update page' do
	context 'when logged in' do
		before :each do
			login_as user
		end
		let :alt_attributes do
			FactoryGirl.attributes_for((class_single + '_alt').to_sym)
		end

		it 'has an edit page' do
			visit edit_class_path object
			expect(current_path).to eq (edit_class_path object)
		end

		it 'updates the ' + described_class.table_name.singularize.humanize.downcase, :js do
			alt_attributes
			visit edit_class_path object
			fill_attributes class_single.to_sym, alt_attributes 
			click_button :Save
			expect(object.class.count).to eq 1
			expect(object.class.first).to have_attributes alt_attributes
		end

		it 'has an index link' do
			visit edit_class_path object
			expect(page).to have_css 'a', text: class_plural.titleize + " Index", count: 1
		end
	end

	it 'has an alternate factory' do
		FactoryGirl.create((class_single + '_alt').to_sym)
		expect(object.class.count).to eq 2
	end
end
