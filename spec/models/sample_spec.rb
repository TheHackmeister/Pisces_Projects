require 'rails_helper'

RSpec.describe Sample, type: :model do
	it_behaves_like 'a model with invalid attributes', {:pisces_number => [nil, ''], :customer => [nil]}
end
