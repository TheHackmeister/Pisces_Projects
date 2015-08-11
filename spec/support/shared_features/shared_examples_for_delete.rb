RSpec.shared_examples 'a delete page' do
	context 'when logged in as an admin' do
		before :each do
			login_as admin
			visit class_path object 
		end
	
		it 'deletes the ' + described_class.name.underscore do
			expect{find('a', text: 'Destroy').click}.to change{
				object.class.count}.by -1
		end
	end
end
