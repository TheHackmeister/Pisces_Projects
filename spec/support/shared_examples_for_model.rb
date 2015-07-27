# invalid_attributes should be in the attribute => [invalid values]
RSpec.shared_examples 'a model with invalid attributes' do |invalid_attributes|
		# This tests each invalid attribute passed in.
		invalid_attributes.each { |attribute, values|
			context 'for ' + attribute.to_s do
				values.each { |value|
					it 'does not accept ' + value.to_s do
						object = FactoryGirl.build(described_class.name.downcase.to_sym, attribute.to_sym => value)
						expect(object.valid?).to eq false
					end
				}
			end
		}
end

