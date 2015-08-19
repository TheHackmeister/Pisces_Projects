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

  def fill_attributes model_name, attributes, driver=nil
    attributes.each do |field, value|
			# Skip if own ID. 
			next if field == 'id' 

			# If it's a reference. 
      if field.to_s.index('_id') != nil
        field_class = field[0..field.length - 4].classify.constantize 
			
				# Searchable reference.
				if field_class.reference_type_is_search? 
					# This makes sure any created indexes are up to date. 
					if field_class.respond_to? :reindex
						field_class.reindex
					end
					finder = 'input#' + model_name.to_s + "_" + to_name(field_class) + "_" + to_name(field_class)
					find(finder).set ''
					find(finder).native.send_keys(field_class.find_by_id(value).to_s.strip.gsub(/^.*:/, "")) # /^.*:/ takes care of searching for customers, who you can search for the id or name, but not both. 
					find("a", text: field_class.find_by_id(value).to_s.strip, match: :prefer_exact).trigger 'click'
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
