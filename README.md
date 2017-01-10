# Builder Bob

Builder Bob is a data generation and loading framework for Ruby on Rails.

Postgresql is currently the only supported database adapter.

## TODO
* Add support for other databases
* Add support to store and load data templates from AWS S3
* Add section got common gotchyas

## Installation

Add Builder Bob to your Gemfile
```
gem 'builder_bob, :git => 'git://github.com/ecstatic-labs/builder_bob.git'
```

Run bundle install
```
bundle install
```

Run Builder Bob installer
```
rails g builder_bob:install
```
This add the following files and folders:
* config/environments/builder_bob/rb
* lib/builder_bob/data_templates/

This also appends a builder_bob database environment configuration to ```config/database.yml```

## Usage

Builder Bob provides rake tasks to start data templates, save data templates into database files, and load saved data templates into a specified database.

Create a data template named minimal_configuration
```
rails g builder_bob:data_template minimal_configuration
```

Save a data template
```
RAILS_ENV=builder_bob rake builder_bob:save_data_template\[template_name\]
```

Reset database and load a data template
```
rake builder_bob:reset_and_load\[template_name\]
```
