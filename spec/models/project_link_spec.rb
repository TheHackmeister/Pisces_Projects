require 'rails_helper'

RSpec.describe ProjectLink do
	it 'cleans "(",")", and " " from % codes from links' do
		link = FactoryGirl.create(:project_link, :url => "http://www.example.com/%28%29%20junk")
		expect(link.url).to eq "http://www.example.com/() junk"
	end
	context 'adds file:\\\\\\ to links that are files' do
		it 'for local links with quotes' do
			link = FactoryGirl.create(:project_link, :url => '"Z:\Data\example.txt"')
			expect(link.url).to eq "file:///Z:\\Data\\example.txt"
		end

		it 'for local links without quotes' do
			link = FactoryGirl.create(:project_link, :url => 'Z:\Data\example.txt')
			expect(link.url).to eq "file:///Z:\\Data\\example.txt"
		end

		it 'for lowercase links' do
			link = FactoryGirl.create(:project_link, :url => 'z:\Data\example.txt')
			expect(link.url).to eq "file:///z:\\Data\\example.txt"
		end
	end

end
