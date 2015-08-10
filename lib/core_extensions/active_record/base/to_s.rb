module ActiveRecord
	class Base
		def to_s
			if respond_to?(:title) 
				if title
					return title
				else
					return "None"
				end
			elsif respond_to?(:text) 
				if text
					return text
				else
					return "None"
				end
			else
				return super
			end
		end
	end
end
