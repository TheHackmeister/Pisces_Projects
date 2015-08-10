RSpec.shared_context "features", a: :b do
	include_context 'application'

	let(:class_name) {described_class.name.underscore}
end
