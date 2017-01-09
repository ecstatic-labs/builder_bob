$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "builder_bob/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "builder_bob"
  s.version     = BuilderBob::VERSION
  s.authors     = ["Kevin Bahr"]
  s.email       = ["kevbahr@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BuilderBob."
  s.description = "TODO: Description of BuilderBob."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pg"
end
