Dir[File.join(Rails.root, 'lib', 'builder_bob', 'data_templates', '**', '*.rb')].each { |l| require l }

namespace :builder_bob do
  desc 'Explaining what the task does'
  task :save_data_template, [:data_template_name] => :environment do |_t, args|
    fail 'Can only run this in builder_bob environment' unless Rails.env.builder_bob?
    fail 'Please provide a name for the data template to load' unless args[:data_template_name].present?

    puts 'RAILS_ENV=builder_bob bundle exec rake db:reset'
    `RAILS_ENV=builder_bob bundle exec rake db:reset`
    fail 'Could not reset builder_bob database' unless $CHILD_STATUS.to_i.zero?

    data_template_name = args[:data_template_name]
    klass_name = data_template_name.camelize

    klass = Object.const_get "BuilderBob::DataTemplates::#{klass_name}"
    klass.generate_data

    sql_directory = "#{Rails.root}/lib/builder_bob/data_templates/#{data_template_name}/"
    Dir.mkdir(sql_directory) unless File.exist?(sql_directory)
    sql_file = "#{sql_directory}#{data_template_name}.sql"
    puts "Writing builder_bob database to #{sql_file}"
    File.truncate(sql_file, 0) if File.exist?(sql_file)
    File.open(sql_file, 'w') do |f|
      f.puts('-- This is generated file, do not edit.')
    end

    config = Rails.configuration.database_configuration[Rails.env]
    fail "Database adapter currently only supports postgresql. #{config['adapter']} provided." unless config['adapter'] == 'postgresql'
    database = config['database']

    # TODO: Build support for other databases
    puts 'Dumping database...'
    `pg_dump --data-only --disable-triggers --column-inserts --exclude-table=schema_migrations #{database} >> #{sql_file}`

    content = IO.read(sql_file)
    content = content.gsub(/^SET search_path = public, pg_catalog;$/, '-- SET search_path = public, pg_catalog;')
    content = content.gsub(/^SET row_security = off;$/, '-- SET row_security = off;')

    File.write(sql_file, content)
  end

  desc 'Explaining what the task does'
  task :reset_and_load, [:data_template_name] => :environment do |_t, args|
    fail 'Do not run this task in production' if Rails.env.production?
    fail 'Please provide a name for the data template to load' unless args[:data_template_name].present?

    data_template_name = args[:data_template_name]

    puts "RAILS_ENV=#{Rails.env} bundle exec rake db:drop"
    `RAILS_ENV=#{Rails.env} bundle exec rake db:drop`
    fail "Could not drop #{Rails.env} database" unless $CHILD_STATUS.to_i.zero?
    puts "RAILS_ENV=#{Rails.env} bundle exec rake db:create"
    `RAILS_ENV=#{Rails.env} bundle exec rake db:create`
    fail "Could not create #{Rails.env} database" unless $CHILD_STATUS.to_i.zero?
    puts "RAILS_ENV=#{Rails.env} bundle exec rake db:migrate"
    `RAILS_ENV=#{Rails.env} bundle exec rake db:migrate`
    fail "Could not run #{Rails.env} migrations" unless $CHILD_STATUS.to_i.zero?

    file = BuilderBob.get_data_template(data_template_name)

    puts "Loading #{data_template_name}"
    ActiveRecord::Base.connection.execute(file)
    puts "Loaded #{data_template_name}"
  end
end
