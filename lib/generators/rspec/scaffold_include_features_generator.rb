# To use: set test_framework in config/application. 
# Set g.fallbacks[:rspec_scaffold_include_features] = :rspec

require 'generators/rspec'
class Rspec::ScaffoldIncludeFeaturesGenerator < Rails::Generators::NamedBase

	def call_rspec_features
		invoke 'rspec:feature'
	end

  hook_for :test_framework, as: :rspec_scaffold_include_features
end
