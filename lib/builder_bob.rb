require 'builder_bob/railtie' if defined?(Rails)

module BuilderBob
  # Default way to set up Devise. Run rails generate builder_bob:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end

  # TODO: this method will change depending on the source of template files (tmp or S3)
  def self.get_data_template(data_template_name)
    File.read("#{Rails.root}/lib/builder_bob/data_templates/#{data_template_name}/#{data_template_name}.sql")
  end

  # The environment that will be used to build data in
  mattr_accessor :seed_environment
  @@seed_environment = 'builder_bob'
end
