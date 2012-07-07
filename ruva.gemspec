# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ruva/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Samuel Mueller"]
  gem.email         = ["mueller.samu@gmail.com"]
  gem.description   = %q{description}
  gem.summary       = %q{summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ruva"
  gem.require_paths = ["lib"]
  gem.version       = Ruva::VERSION
  
  gem.add_dependency "citrus", "~> 2.4.1"
  
  gem.add_development_dependency "rspec", "~> 2.6"
end
