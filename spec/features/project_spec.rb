require 'rails_helper'
include Warden::Test::Helpers


RSpec.describe Project, :type => :feature do
	include_context 'features' 

	it_behaves_like 'a create page'
	it_behaves_like 'a delete page' 
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an update page'
	
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
      FactoryGirl.create(:project_link, :project => @project, :notes => "Test notes.")
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
          expect(page).to have_attributes contact_attributes
					sleep 1 # Not a good fix, but was getting a DB locked error consistantly. Consider addressing it in have_attributes
          expect(Contact.count).to eq 1
        end
      end
    end
  end

	it 'has communication tests'
=begin
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
          find('input#communication_contact_contact').native.send_keys(@contact)
          find('a', :text => @contact).click
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
          find('input#communication_contact_contact').native.send_keys('Contact')
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
=end
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
     expect(page).to have_attributes step.attributes.except 'project_id'
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
