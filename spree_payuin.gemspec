$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree/payuin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_payuin"
  s.version     = Spree::Payuin::VERSION
  s.authors     = ["Varun Arbatti", "Pavan Sudarshan"]
  s.email       = ["varun.arbatti@thoughtworks.com"]
  s.summary     = "Payuin Gateway implementation for spree"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "spree", "~> 1.2.0"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'faker'
end
