require 'rspec/expectations'

RSpec::Matchers.define :have_attributes do |expected|
  match do |actual|
		expected.each { |key, value|
			if actual[key.to_s].to_s != value.to_s
				puts key.to_s + ' does not match: ' + value.to_s + ', ' + actual[key.to_s].to_s
				return false
			end
		}
		true
  end
end

