module ActiveRecord
	class Base
		def js_name
			self.class.table_name.singularize
		end
	end
end
