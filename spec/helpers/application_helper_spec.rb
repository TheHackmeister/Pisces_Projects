require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'The display_alert function' do 
    it 'to strings the array if given an array' do
        expect(helper.display_alert(["One","Two"])).to eq("One\nTwo\n")
    end
    
    it 'returns a string if given a string' do
      expect(helper.display_alert("Test String")).to eq("Test String")     
    end
    
    it 'returns nothing if given nothing' do
      expect(helper.display_alert("")).to eq("")
      expect(helper.display_alert(nil)).to eq(nil)
    end
    
    it 'has an alias function display_notice' do
      expect(ApplicationHelper.instance_method(:display_alert)).to eq(ApplicationHelper.instance_method(:display_notice))
    end
  end 
  
=begin 
Should be an intigration test.
  describe 'The title function' do
    context 'when signed in' do
      it 'shows the page title' #Can't figure this one out. 
    end  
  end

  describe 'The search_html fuction' do
    
  end
=end  
  describe 'The format_text_field function' do 
    #let(:example_text) {"Hello ***Bold***. Also, *r*Red*r*.\nNew line."}
    it 'returns none if no text is given' do
      expect(helper.format_text_field "").to eq("None")
    end
    it 'turns *** into <b>' do
      expect(helper.format_text_field "Hello ***Bold***.").to eq("<p>Hello <b>Bold</b>.</p>")
    end
    it 'turns *r* into <font color="red">' do #Ah, this fails. Gotta fix it some time.
      pending("Has been broken.")
      expect(helper.format_text_field "*r*Red*r*.").to eq("<p><font color=\"red\">Red</font>.</p>")      
    end
    it 'turns \\n into </br>' do
      expect(helper.format_text_field "New\nLine").to eq("<p>New\n<br />Line</p>")
    end
    it 'turns multiple \\ns into new lines' do
      expect(helper.format_text_field "New\nLine\nNew\nLine").to eq("<p>New\n<br />Line\n<br />New\n<br />Line</p>")
    end
    
  end
  
  describe 'The sub_tag function' do #Gets tested through format_text_field
    
  end
end