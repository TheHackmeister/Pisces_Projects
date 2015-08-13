# This support package contains modules for filling in and checking forms. 

module FormFillHelper 
  def cap_login 
    login_as FactoryGirl.create(:user), :scope => :user
  end

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
=begin
  def has_attributes attributes
    attributes.each do |field, value|
      next if field == 'id' || field == 'created_at' || field == 'updated_at'
      if field.index('_id') != nil  
        field_class = field[0..field.length - 4].classify.constantize      
        #I had to do it this way because expect(page).to have_content("Pisces Molecular") looked for the customer ID instead. WEIRD.
        expect(has_text?(field_class.find_by_id(value).to_s)).to eq true
      else
        expect(page).to have_content value
      end
    end
  end
=end
  def fill_attributes model_name, attributes
    attributes.each do |field, value|
			# Skip if own ID. 
			next if field == 'id' 

			# If it's a reference. 
      if field.to_s.index('_id') != nil
        field_class = field[0..field.length - 4].classify.constantize 
			
				# Searchable reference.
				if field_class.reference_type_is_search? 
					finder = 'input#' + model_name.to_s + "_" + to_name(field_class) + "_" + to_name(field_class)
					find(finder).set ''
					find(finder).native.send_keys(field_class.find_by_id(value).to_s)
					find('a', text: field_class.find_by_id(value).to_s).click
				else # Drop down reference.
					select(field_class.find_by_id(value).to_s, :from => model_name.to_s + "_" + field.to_s)
				end

			# it's a Date
			elsif (model_name.to_s.classify.constantize.column_for_attribute(field).type) == :date 
				select_date value.to_date, from: model_name.to_s + '_' + field.to_s
			else
        fill_in model_name.to_s + "_" + field.to_s, :with => value
      end
    end
  end

	private
	def to_name model
		model.name.underscore
	end

end

# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
    # Include the help for the request specs.
    config.include FormFillHelper 
end
