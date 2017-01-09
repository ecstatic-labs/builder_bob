module BuilderBob
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/builder_bob_tasks.rake'
    end
  end
end
