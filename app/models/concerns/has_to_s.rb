module HasToS
	extend ActiveSupport::Concern

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

	def ef
		return "It Works"
	end
end
