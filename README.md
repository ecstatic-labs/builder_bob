# Builder Bob

Builder Bob is a data generation and loading framework for Ruby on Rails.

Postgresql is currently the only supported database adapter.

## TODO
* Add support for other databases
* Add support to store and load data templates from AWS S3
* Add section got common gotchyas

## Installation

Add Builder Bob to your Gemfile
```ruby
gem 'builder_bob, git: 'git://github.com/ecstatic-labs/builder_bob.git'
```

Run bundle install
```
bundle install
```

Run Builder Bob installer
```
rails g builder_bob:install
```
This adds the following files and folders:
* config/environments/builder_bob/rb
* lib/builder_bob/data_templates/

This also appends a builder_bob database environment configuration to ```config/database.yml```

## Usage

Builder Bob provides rake tasks to start data templates, save data templates into database files, and load saved data templates into a specified database.

### Create a data template named minimal_configuration
```
rails g builder_bob:data_template minimal_configuration
```
This adds the following files and folders:
* lib/builder_bob/data_templates/minimal_configuration/
* lib/builder_bob/data_templates/minimal_configuration/minimal_configuration.rb

The ```minimal_configuration.rb``` file is its own class within
```BuilderBob::DataTemplates``` module with a single class method:
```self.generate_data```. This class is where you will create data any
way you choose:

```ruby
module BuilderBob
   module DataTemplates
     class MinimalConfiguration
       def self.generate_data
         Book.create!(title: 'The Lord of the Rings')
         Book.create!(title: 'The Hobbit')
       end
     end
   end
end
```

### Save a data template named minimal_configuration
```
RAILS_ENV=builder_bob rake builder_bob:save_data_template\[minimal_configuration\]
```

This task resets the ```builder_bob``` environment database, executes the
```BuilderBob::DataTemplates::MinimalConfiguration.generate_data``` class
method, and then dumps the ```builder_bob``` environment database to an
sql file to ```lib/builder_bob/data_templates/minimal_configuration/minimal_configuration.sql```

### Reset database and load a data template named minimal_configuration
```
rake builder_bob:reset_and_load\[minimal_configuration\]
```

This task resets the ```builder_bob``` environment database and re-creates the database from the sql file located at ```lib/builder_bob/data_templates/minimal_configuration/minimal_configuration.sql```
