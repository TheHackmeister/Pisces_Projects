require 'rails_helper'

RSpec.describe "Application", :type => :feature do
  it 'allows users to log in', :js do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    #fill_attributes :user, user.attributes.slice(:email, :password)
   
    fill_in :user_email, :with => 'example@example.com'
    fill_in :user_password, :with => 'example123'
    
    click_button 'Log in'
    expect(find("#flash").text).to eq "Signed in successfully." #have_selector('#flash', visible: true)
  end  

  it 'allows users to log out' do
    cap_login
    visit projects_path
    click_link :Logout
    expect(current_path).to eq new_user_session_path
  end

  it 'should redirect non-logged in users correctly', :js do
    visit projects_path
    expect(current_path).to eq new_user_session_path
  end

  it 'has a flash that is always displayed' 
	it 'has tests for EmailToProject interface'
end
