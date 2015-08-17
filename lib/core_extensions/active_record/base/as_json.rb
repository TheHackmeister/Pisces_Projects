module ActiveRecord
	class Base
		def as_json options = {}
			options[:methods] = :to_s
			super options
		end
	end
end
