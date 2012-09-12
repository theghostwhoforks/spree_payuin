$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_payuin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_payuin"
  s.version     = SpreePayuin::VERSION
  s.authors     = ["vi"]
  s.email       = ["flawed.flint@gmail.com"]
  s.summary     = "Payu Gateway implementation for spree"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "spree", "~> 1.2.0"
end
