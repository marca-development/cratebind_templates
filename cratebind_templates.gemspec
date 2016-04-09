$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cratebind/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cratebind_templates"
  s.version     = Cratebind::VERSION
  s.authors     = ["Jordan Graft"]
  s.email       = ["jordan@cratebind.com"]
  s.homepage    = "https://cratebind.com/open-source/cratebind_templates"
  s.summary     = "Rails generators for creating API resources"
  s.description = "Rails generators for creating API resources as well as Angular templates"
  s.license     = "MIT"
  s.require_path = 'lib'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-byebug'  
end
