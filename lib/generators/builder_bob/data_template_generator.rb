require 'rails/generators/base'

module BuilderBob
  module Generators
    class DataTemplateGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      argument :name, :type => :string, :default => "data_template_#{DateTime.current.strftime('%Y_%m_%d_%H%M')}"

      def generate_template
        # TODO: sanitize name to ensure it can be made as a folder and also a class
        empty_directory "lib/builder_bob/data_templates/#{name}/"
        create_file "lib/builder_bob/data_templates/#{name}/#{name}.rb"
        append_to_file "lib/builder_bob/data_templates/#{name}/#{name}.rb" do
          "module BuilderBob\n"\
          "  module DataTemplates\n"\
          "    class #{name.camelize}\n"\
          "      # Use this method to create data however you wish\n"\
          "      def self.data\n"\
          "      end\n"\
          "    end\n"\
          "  end\n"\
          "end"
        end
      end
    end
  end
end
