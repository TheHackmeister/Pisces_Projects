require 'rails_helper'

RSpec.describe ProjectType do

	it 'has a factory' do
		FactoryGirl.create(:project_type)
		expect(ProjectType.count).to eq 1
	end
	it 'requires text to be present' do
		project_type = FactoryGirl.build(:project_type, text: "")
		expect(project_type.valid?).to eq false
	end
	it 'sorts by sort by default' do
		7.times { FactoryGirl.create(:project_type)} 
		first = FactoryGirl.create(:project_type, sort: 0)
		expect(ProjectType.first).to eq first
	end
end
