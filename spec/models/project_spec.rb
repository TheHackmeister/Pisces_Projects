require 'rails_helper'

RSpec.describe Project do
  
  # Begin tests for validation.
  context 'validations work' do 
    before(:each) do 
      @project = FactoryGirl.create(:project)
    end
  
    it 'has a valid factory' do
      expect(@project).to be_valid
    end
    
    it 'accepts ["Strings", 1, -1] for title' do
      puts @project
      ["Strings", 1, -1].each do |obj|
        @project.title = obj
        expect(@project).to be_valid        
      end
    end    
    it 'does not accept ["", nil] for title' do
      ["", nil].each do |obj|
        @project.title = obj
        expect(@project).to_not be_valid        
      end 
    end  
    
    it 'accepts [3, 382] for customer_id' do
      [3,382].each do |obj|
        @project.customer_id = obj
        expect(@project).to be_valid        
      end
    end
    it 'does not accept ["Strings", "", nil, 900000000, 0, -1] for customer_id' do
      ["Strings", "", nil, 900000000, 0, -1].each do |obj|
        @project.customer_id = obj
        expect(@project).to_not be_valid        
      end 
    end  
    
    it 'accepts [1] for priority_id' do
      [1].each do |obj|
        @project.priority_id = obj
        expect(@project).to be_valid        
      end
    end
    it 'does not accept ["Strings", "", nil, 900000000, 0, -1] for priority_id' do
      ["Strings", "", nil, 900000000, 0, -1].each do |obj|
        @project.priority_id = obj
        expect(@project).to_not be_valid        
      end 
    end  
    
    it 'accepts [1] for status_id' do
      [1].each do |obj|
        @project.status_id = obj
        expect(@project).to be_valid        
      end
    end
    it 'does not accept ["Strings", "", nil, 900000000, 0, -1] for status_id' do
      ["Strings", "", nil, 900000000, 0, -1].each do |obj|
        @project.status_id = obj
        expect(@project).to_not be_valid        
      end 
    end  

		it 'requires a project type' do
			[nil].each do |obj|
				@project.project_type_id = obj
				expect(@project).to_not be_valid
			end
		end

  end
# End tests for validation.  
  
# Begin tests for delegations.
  context 'delegations' do
    let(:project) {project = FactoryGirl.create(:project)}
    let(:project_with_step) {project = FactoryGirl.create(:project_with_step)}
    #before(:each) do 
    #  @project = FactoryGirl.create(:project)
    #  FactoryGirl.create(:step_status)
    #end
  
    it 'will respond with priority text' do
      expect(project.priority_text).to eq(Priority.find(project.priority_id).text)      
    end
    
    it 'will respond with priority value' do
      expect(project.priority_val).to eq(Priority.find(project.priority_id).val)
    end
    
    it 'will respond with customer name' do
      expect(project.customer_name).to eq(Customer.find(project.customer_id).customer_name)
    end
    
    it 'gives empty string if there is no step, and thus no action' do
      expect(project.get_first_step_action).to eq("")
    end
    
    it 'gives empty string if there is no step, and thus no date date' do 
      expect(project.get_first_step_date).to eq("")
    end
    
    it 'gives empty string if there is no step date' do 
      expect(FactoryGirl.create(:project_with_step, step_due: nil ).get_first_step_date).to eq(nil)
      #This can be done, but won't happen often as there isn't a way in the interface to not set a date.
    end
    
    it 'returns the date if there is a step' do
      expect(project_with_step.get_first_step_date).to eq("10/10/2010".to_date)      
    end
    
    it 'return the action if there is a step' do
      expect(project_with_step.get_first_step_action).to eq('Action')
    end

    it 'returns status text' do
      expect(project.status_text).to include 'Status text'
    end    
    
    it 'returns status value' do 
      expect(project.status_val).to be > 0
    end

		it 'returns project type text' do
			expect(project.project_type_text).to include "Project Type"
		end

  end
# End tests for delegations.
	it 'models have a to_s spec'
end
