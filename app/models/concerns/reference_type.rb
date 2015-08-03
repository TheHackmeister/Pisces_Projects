module ReferenceType
	extend ActiveSupport::Concern

	module ClassMethods
		def reference_type type=nil
			if type
				@@reference_type = type
			else
				@@reference_type
			end
		end
	end
end
