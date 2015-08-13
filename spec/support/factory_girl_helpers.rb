module FactoryHelpers
  def reference_main reference
		sequence((reference.to_s + '_id').to_sym) {
			if reference.to_s.classify.count < 1
				(create reference).id
			else
				reference.to_s.classify.last.id
			end
		}
  end

	def reference_alt reference
		if reference.to_s.classify.count < 2
			(create reference).id
		else
			reference.to_s.classify.last.id
		end
	end
end

FactoryGirl::SyntaxRunner.send(:include, FactoryHelpers)
