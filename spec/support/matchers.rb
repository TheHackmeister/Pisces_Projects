require 'rspec/expectations'

RSpec::Matchers.define :have_attributes do |expected|
  match do |actual|
		# Given page instead of a model. 
		if actual.is_a? Capybara::Session 
			expected.each { |field, value|
				next if field == 'id' || field == 'created_at' || field == 'updated_at' # Skip these default attributes. 
				# It's a reference. 
				if field.index('_id') != nil  
					field_class = field[0..field.length - 4].classify.constantize      
					search = field_class.find_by_id(value).to_s
				# It's a normal attribute. 
				else
					search = value.to_s
				end
				
				# If page doesn't have text, throw failure. 
				if not has_text?(search) 
					return false
				end
			}
		# Given a model. 
		else 
			expected.each { |key, value|
				# If actual and expected don't match, throw failure. 
				if actual[key.to_s].to_s != value.to_s
					return false
				end
			}
		end 

		return true
  end
	failure_message do |actual|
		# Given page instead of a model. 
		if actual.is_a? Capybara::Session
			expected.each { |field, value|
				next if field == 'id' || field == 'created_at' || field == 'updated_at' # Skip these default attributes. 
				# It's a reference. 
				if field.index('_id') != nil  
					field_class = field[0..field.length - 4].classify.constantize      
					search = field_class.find_by_id(value).to_s
				# It's a normal attribute. 
				else
					search = value.to_s
				end
			
				# If page doesn't have text, throw failure. 
				if not has_text?(search)
					return 'Could not find "' + search + '" in ' + page.text.to_s
				end	
			}
		# Given a model. 
		else
			expected.each { |key, value|
				# If actual and expected don't match, throw failure. 
				if actual[key.to_s].to_s != value.to_s
					return 'Expected ' + key.to_s + ' to eq: ' + value.to_s + 
						'. Got: ' + actual[key.to_s].to_s
				end
			}
		end
	end
end


