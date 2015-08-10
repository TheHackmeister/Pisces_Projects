RSpec.shared_context "controllers", a: :b do
	include_context 'application'
	let(:class_name) {described_class.controller_name.underscore.singularize}
end
