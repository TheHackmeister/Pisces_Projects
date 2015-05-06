require 'rails_helper'
include Warden::Test::Helpers


RSpec.describe Project, :type => :feature do
 
  context 'creates a project' do 
    context 'when not logged in' do
      it 'redirects to the login page' do
        visit new_project_path
        expect(current_path).to eq(new_user_session_path)
      end  
    end
    
    context 'when logged in', :js do
      before(:each) do
        FactoryGirl.create(:priority)
        FactoryGirl.create(:status)
        cap_login
        visit new_project_path
        expect(current_path).to eq(new_project_path)
        fill_in :project_title, :with => "Project Title"
        select_date('10/16/2015'.to_date, :from => :project_started)
        select_date('10/16/2016'.to_date, :from => :project_soft_deadline)
        select('Urgent', :from => :project_priority_id)
        select('Not Started', :from => :project_status_id)
        fill_in :project_goal, :with => "GOAL"
        fill_in :project_notes, :with => "Pisces Notes"
        fill_in :project_customer_notes, :with => 'Customer notes'
        fill_in :project_stumbling_blocks, :with => 'Stumbling Blocks'
        find('input#project_customer_customer').native.send_keys('Pisces')
        #This is a poor solution. Why 
        #sleep 5
        #click_link "Pisces Molecular"
        find('a', :text => "Pisces Molecular").click
        #page.driver.render('./log/screen_1Home.png', :full => true)
        click_button :Submit       
      end
      
      it 'it creates a project' do 
        expect(Project.count).to eq 1
        expect(Project.first.customer_name).to eq "Pisces Molecular"
      end
      
      it 'redirects to the new project' do
        expect(current_path).to eq project_path Project.first 
      end
    end
  end
  
  context 'view a project' do
    before(:each) do
      @project = FactoryGirl.create(:project)
    end
    
    context 'not logged in' do
      it 'redirects to the login page' do
        visit project_path @project
        expect(current_path).to eq(new_user_session_path)
      end 
    end
    
    context 'logged in' do
      it 'shows the project' do 
        cap_login  
        visit project_path @project
        expect(current_path).to eq( project_path @project)
        #expect(@project.attributes).to eq ""
        has_attributes @project.attributes
      end 
    end
  end
  
  context 'edit a project' do 
    before(:each) do 
      @project = FactoryGirl.create(:project)
    end
    context 'not logged in' do
      it 'redirects to the login page' do
        visit edit_project_path @project
        expect(current_path).to eq(new_user_session_path)
      end
    end
    
    context 'logged in', :js do
      before(:each) do
        cap_login
        visit edit_project_path @project
        @modified_form = {'title' => "New Title", 'goal' => 'New Goal', 'notes' => 'New Note', 'customer_notes' => "New customer notes", 'stumbling_blocks' => 'New stumbling'}
        
        fill_attributes :project, @modified_form
        select_date('10/16/2015'.to_date, :from => :project_started)
        select_date('10/16/2016'.to_date, :from => :project_soft_deadline)
        select('Urgent', :from => :project_priority_id)
        select('Not Started', :from => :project_status_id)
        find('input#project_customer_customer').native.send_keys('Pisces')
        
        click_button :Submit
      end
      it 'redirects to the projects page' do
        expect(current_path).to eq(project_path @project)                
      end
      
      it 'displays the updated information' do 
        has_attributes @modified_form
      end
    end
    
  end
  
  context 'links', :js do
    before(:each) do
      @project = FactoryGirl.create(:project)
      cap_login
      visit project_path @project
    end
    let(:link_attributes) {{'name' => 'Link Name', 'url' => "Link URL", 'notes' => "Link notes" }}
    #Assumed logged in? 
    context 'if valid' do
      it 'can be added' do
        within('#new_project_link') do 
          fill_attributes :project_link, link_attributes
          
          click_button :Add
          
        end              
        visit project_path @project
        expect(page).to have_link('Link Name')
        expect(page).to have_content('Link notes')
      end
    end
    context 'if not valid' do
      it 'gives an alert' do
        link_attributes = {'name' => '', 'url' => "Link URL", 'notes' => "Link notes" }
        within('#new_project_link') do
          fill_attributes :project_link, link_attributes
          click_button :Add
        end
        expect(page).to have_content("Could not add link. Name can't be blank. Refresh to remove this error.")
      end
    end

    it 'can be deleted' do
      FactoryGirl.create(:project_link, :Project => @project, :notes => "Test notes.")
      visit project_path @project
      within('#links') do
	click_link "X"
      end
      expect(page).to_not have_content("Test notes.")
      expect(page).to have_content("Project link deleted.")
      visit project_path @project
      expect(page).to_not have_content("Test notes.")
    end
  end


  context 'contacts', :js do
    before(:each) do
      @project = FactoryGirl.create(:project)
      cap_login
      visit project_path @project
    end
    let(:contact_attributes) do FactoryGirl.attributes_for(:contact) end
    let(:project) do FactoryGirl.create(:project) end

    context 'create' do
      context 'when not valid' do
        it 'gives an alert' do
          contact_attributes = {'contact_name' => '', 'phone' => "123-456-7890", 'address' => "Contact Address", 'email' => "Contact@Email.com" }
          within('#new_contact') do
            fill_attributes :contact, contact_attributes #FactoryGirl.attributes_for(:contact).merge(:project => '1') #:contact_attributes
            click_button :Add
          end
          expect(page).to have_content("Could not add contact. Contact name can't be blank. Refresh to remove this error.")
        end
      end

      context 'when valid' do
        it 'creates a contact' do
          visit project_path project 
          contact_attributes = {'contact_name' => 'Contact Name', 'phone' => "123-456-7890", 'address' => "Contact Address", 'email' => "Contact@Email.com" }
          within('#new_contact') do
            fill_attributes :contact, contact_attributes 
            click_button :Add
          end
          has_attributes contact_attributes
          expect(Contact.count).to eq 1
        end
      end
    end
  end

 context 'communications', :js do 
  before(:each) do
    @project = FactoryGirl.create(:project)
    @contact = FactoryGirl.create(:contact)
    FactoryGirl.create(:communication_status)
    FactoryGirl.create(:communication_type)
    cap_login
    visit project_path @project
  end
  context 'create' do
    context 'when not valid' do
      it 'gives an alert' do
        comm_attributes = {'summary' => '', 'communication_type_id' => "1", 'communication_status_id' => "1", 'notes' => "Communication Notes" }

        within('#new_communication') do
          fill_attributes :communication, comm_attributes
          find('input#communication_contact_contact').native.send_keys('Contact')
          find('a', :text => "Contact").click
          click_button :Add
        end

        expect(page).to have_content("Could not add communication. Summary can't be blank. Refresh to remove this error.")
        expect(Communication.count).to eq 0
      end
    end
    
    context 'when valid' do
      it 'creates a communication' do
        comm_attributes = {'summary' => 'Summary', 'communication_type_id' => "1", 'communication_status_id' => "1", 'notes' => "Communication Notes" }
        within('#new_communication') do
          fill_attributes :communication, comm_attributes
          find('input#communication_contact_contact').native.send_keys('Contact Name')
          find('a', :text => "Contact").click
          click_button :Add
        end
        expect(page).to have_content("Communication Notes")
        expect(Communication.count).to eq 1
      end
    end
  end
  it 'should be seen in the project' do
    FactoryGirl.create(:communication, :project => @project)
    visit project_path @project
    expect(page).to have_content("Communication notes")
  end
  it 'should be deletable'
 end

 context 'steps', :js do
   before(:each) do
     @project = FactoryGirl.create(:project)
     FactoryGirl.create(:step_status)
     cap_login
     visit project_path @project
   end
   context 'create' do
     context 'when not valid' do
       it 'gives an alert' do
         step_attributes = { 'action' => '', 'note' => 'Step note'}
         within('#new_step') do
           fill_attributes :step, step_attributes
           select_date '10/10/2015'.to_date, :from => :step_due
           click_button :Add
         end
         expect(page).to have_content("Could not add step. Action can't be blank.")
         expect(Step.count).to eq 0
       end
     end
     context 'when valid' do
       it 'creates a step' do
         step_attributes = { 'action' => 'Step action', 'note' => 'Step note'}
         within('#new_step') do
           fill_attributes :step, step_attributes
           select_date '10/10/2015'.to_date, :from => :step_due
           click_button :Add
         end
         expect(page).to have_content("Step note")
         expect(Step.count).to eq 1
       end
     end
   end
   it 'should be seen in the project' do
     step = FactoryGirl.create(:step, :project => @project)
     visit project_path @project
     has_attributes step.attributes.except 'project_id'
   end
 end
  
  
  
  context 'pagation and search' do
    before(:each) do
      51.times do 
        FactoryGirl.create(:project, :multiple_projects => true)
      end
      Project.reindex
      cap_login
    end
    it 'should have links to next page' do
      visit projects_path
      find(:xpath, '//a[normalize-space(.)="2"]').click
      expect(page).to have_content "First"
    end

    it 'should be sortable' do 
      visit projects_path
      click_link 'Priority'
      click_link 'Priority' #I do this twice to get asc, then desc. Arguably, it shouldn't be that way.
      expect(page).to_not have_content 'Urgent'
    end   
  end
end
