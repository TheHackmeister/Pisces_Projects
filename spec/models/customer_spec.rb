require 'rails_helper'

RSpec.describe Customer, type: :model do
#	it_behaves_like 'a model with invalid attributes', {:pisces_number => [nil, ''], :customer => [nil]}
	it 'to_s combineds customer_id and customer_name' do
		pisces = Customer.find 381
		expect(pisces.to_s).to eq pisces.customer_id + ':' + pisces.customer_name
	end
end
