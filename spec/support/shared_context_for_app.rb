RSpec.shared_context "application", a: :b do
	let(:user) {FactoryGirl.create(:user)}
	let(:admin) {FactoryGirl.create(:user, role_title: 'admin', role_val: '2')}
	let(:object) { FactoryGirl.create(described_class.controller_name.singularize.to_sym) }
end
