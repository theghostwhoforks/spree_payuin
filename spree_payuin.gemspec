$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_payuin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_payuin"
  s.version     = SpreePayuin::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SpreePayuin."
  s.description = "TODO: Description of SpreePayuin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "spree", "~> 1.2.0"
  # s.add_dependency "jquery-rails"

  # s.add_development_dependency "sqlite3"
end
