require 'generators/factory_girl'
require 'factory_girl_rails'

module FactoryGirl
  module Generators
    class ModelGenerator < Base
      argument(
        :attributes,
        type: :array,
        default: [],
        banner: "field:type field:type"
      )

      class_option(
        :dir,
        type: :string,
        default: "test/factories",
        desc: "The directory or file root where factories belong"
      )

      def create_fixture_file
        if File.exist?(factories_file)
          insert_factory_into_existing_file
        else
          create_factory_file
        end
      end

      private

      def factories_file
        options[:dir] + ".rb"
      end

      def insert_factory_into_existing_file
        insert_into_file(
          factories_file,
          factory_definition,
          after: "FactoryGirl.define do"
        )
      end

      def create_factory_file
        filename = [table_name, filename_suffix].compact.join('_')
        file = File.join(options[:dir], "#{filename}.rb")
        create_file(file, single_file_factory_definition)
      end

      def factory_definition
<<-RUBY
  factory :#{singular_table_name}#{explicit_class_option} do
#{factory_attributes}
  end
RUBY
      end

      def single_file_factory_definition
<<-RUBY
FactoryGirl.define do
#{factory_definition}
end
RUBY
      end

      def factory_attributes
        attributes.map do |attribute|
					if attribute.type == :string or attribute.type == :text
						"    sequence :#{attribute.name} do |n| '#{attribute.human_name}' + n.to_s end"
					elsif attribute.type == :integer 
						"    sequence :#{attribute.name} do |n| n end"
					elsif attribute.type == :references
						"    #{attribute.name}_id do (create :#{attribute.index_name.gsub(/_id$/, '')}).id end"
					elsif attribute.type == :date
						"    sequence :#{attribute.name} do |n| Date.today() + n.days end"
					else 
	          "    #{attribute.name} #{attribute.default.inspect}"
					end
        end.join("\n")
      end

      def filename_suffix
        factory_girl_options[:suffix]
      end

      def factory_girl_options
        generators.options[:factory_girl] || {}
      end

      def generators
        config = FactoryGirl::Railtie.config
        config.respond_to?(:app_generators) ? config.app_generators : config.generators
      end
    end
  end
end
