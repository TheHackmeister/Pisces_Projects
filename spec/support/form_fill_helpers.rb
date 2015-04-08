# This support package contains modules for filling in and checking forms. 

module FormFillHelper 
  def cap_login 
    login_as FactoryGirl.create(:user), :scope => :user
    #page.driver.render('./log/screen_1Home.png', :full => true)
    #visit new_user_session_path
    #fill_attributes :user, FactoryGirl.attributes_for(:user).slice(:email, :password)
    #fill_in :user_email, :with => 'example@example.com'
    #fill_in :user_password, :with => 'example123'
    #click_button 'Log in'
    #page.driver.render('./log/screen_2Home.png', :full => true)
    #expect(page).to have_content "Signed in successfully"
  end


  #def fill_in_model(model, form, options = {}) 
  #  exclude = options[:exclude] | ['created_on', 'updated_on']
  #  model.data.attributes.each do |att, val| 
  ##    next if exclude.indexOf att != -1
  ##    if model.column_for_attribute(att) == :date 
  #      select_date(val, form + '_' + att)
  #    else if model.column_for_attribute(att) == :references 
  #      #Need to figure out how to do HTML_search.
  #    else 
  #      fill_in form + "_" + att, :with => val
  ##    end
  #  end
  #end


  def select_by_id(id, options = {})
    field = options[:from]
    option_xpath = "//*[@id='#{field}']/option[#{id}]"
    option_text = find(:xpath, option_xpath).text
    select option_text, :from => field
  end 

  def select_date(date, options = {})
    field = options[:from]
    select date.year.to_s,   :from => "#{field}_1i"
    select_by_id date.month, :from => "#{field}_2i"
    select date.day.to_s,    :from => "#{field}_3i"  
  end

  def has_attributes attributes
    attributes.each do |field, value|
      next if field == 'id' || field == 'created_at' || field == 'updated_at'
      if field.index('_id') != nil  
        field_class = field[0..field.length - 4].classify.constantize      
        #I had to do it this way because expect(page).to have_content("Pisces Molecular") looked for the customer ID instead. WEIRD.
        expect(has_text?(field_class.find_by_id(value).text)).to eq true
      else
        expect(page).to have_content value
      end
    end
  end

  def fill_attributes model_name, attributes
    attributes.each do |field, value|
      #page.driver.render('./log/screen_1Home.png', :full => true)
      next if field == 'id' 
      if field.to_s.index('_id') != nil
        field_class = field[0..field.length - 4].classify.constantize 
        select(field_class.find_by_id(value).text, :from => model_name.to_s + "_" + field)
      else
        fill_in model_name.to_s + "_" + field.to_s, :with => value
      end
    end
  end

end

# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
    # Include the help for the request specs.
    config.include FormFillHelper 
end
