require 'rails/generators/base'

module BuilderBob
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      def copy_initializer
        # TODO: initializer file not yet needed
        # template 'initializer/builder_bob.rb', 'config/initializers/builder_bob.rb'
        # puts 'Created config/initializers/builder_bob.rb'
      end

      def copy_environment
        copy_file 'environment/builder_bob.rb', 'config/environments/builder_bob.rb'
        puts 'Created config/environments/builder_bob.rb'
      end

      def add_environment_to_database_config
        append_to_file 'config/database.yml' do
          "\n"\
          "# Configuration for seed database from builder_bob gem\n"\
          "builder_bob:\n"\
          "  <<: *default\n"\
          "  database: builder_bob"
        end
      end

      def create_data_template_directory
        empty_directory 'lib/builder_bob/data_templates/'
      end
    end
  end
end
