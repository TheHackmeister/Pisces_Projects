# This support package contains functions for shortening 
# frequently used class name conversions in the shared context controller. 

module SharedContextHelper
=begin
	def class_single
			describe_class.controller_name.singularize
		end
=end
#begin
	def class_single
		described_class.controller_name.singularize
	end
#end
	def class_plural
		described_class.controller_name
	end

	def class_model
		described_class.controller_name.classify.constantize
	end
end

RSpec.configure do |config|
    # Include the help for the request specs.
    config.include SharedContextHelper 
end
