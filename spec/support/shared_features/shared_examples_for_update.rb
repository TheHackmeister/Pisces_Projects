RSpec.shared_examples 'an update page' do
	context 'when logged in' do
		before :each do
			login_as user
		end
		let :alt_attributes do
			FactoryGirl.attributes_for((class_single).to_sym)
		end

		it 'has an edit page' do
			visit edit_class_path object
			expect(current_path).to eq (edit_class_path object)
		end

		it 'updates the ' + described_class.table_name.singularize.humanize.downcase, :js do
			object
			alt_attributes
			visit edit_class_path object
			fill_attributes class_single.to_sym, alt_attributes 
			click_button :Save
			object.reload
			expect(object).to have_attributes alt_attributes
		end

		it 'has an index link' do
			visit edit_class_path object
			expect(page).to have_css 'a', text: class_plural.titleize + " Index", count: 1
		end
	end

	it 'has a factory that creates a completely unique object' do
		object
		attributes = FactoryGirl.attributes_for class_single.to_sym
		
		attributes.each {|key, value|
			expect(object.send(key)).to_not eq value
		}
	end
end
