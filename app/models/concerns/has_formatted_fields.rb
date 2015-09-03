module HasFormattedFields
  extend ActiveSupport::Concern

	def format_text_field arg
		ApplicationController.helpers.format_text_field arg
	end

	def format_text_fields bool=true
		@format_text_fields = bool		
	end

	def format_text_fields?
		@format_text_fields
	end

	module ClassMethods
		# Expects a list of symbols that it should create new functions for. 
		def formattable_text_fields *args
			# Creates a new method for each formattable tag. 
			args.each do |arg|
				# Actually creates the function. The send is nessisary to make it an instance method. 
				self.send(:define_method, arg.to_s, lambda {
					if format_text_fields? == true
						format_text_field(super())
					else
						super()
					end
				})
			end
		end

	end

end
