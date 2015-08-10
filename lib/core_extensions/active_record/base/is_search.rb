module ActiveRecord
	class Base
		def self.reference_type_is_search? 
			if @not_search  
				return false
			elsif self.all.respond_to? :filter or self.all.respond_to? :search
				return true
			else
				return false
			end
		end
		

		def self.reference_type_is_not_search bool
			@not_search = bool
		end
	end
end
