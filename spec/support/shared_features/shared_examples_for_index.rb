RSpec.shared_examples 'an index page' do 
	context 'when logged in' do
		let :unmodified_index_count do 3 end
		let :index_count do 
			if described_class.name == 'Role' 
				unmodified_index_count + 1
			else
				unmodified_index_count
			end
		end
		before :each do
			login_as user
			unmodified_index_count.times do
				FactoryGirl.create class_single.to_sym
			end
			visit class_path
		end
		
		it 'has an index page' do
			expect(current_path).to eq class_path
		end
		
		it 'has a table with the ' + described_class.table_name.humanize.downcase do
			expect(page).to have_css 'tr', count: index_count + 1
		end

		it 'has a new link' do
			expect(page).to have_css 'a', text: 'New ' + class_single.humanize
		end
	end
end
