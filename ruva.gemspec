# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ruva/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "ruva"
  gem.version       = Ruva::VERSION

  gem.authors       = ["Samuel Mueller"]
  gem.email         = ["mueller.samu@gmail.com"]
  gem.description   = %q{A library to write plain text conditions.}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/ssmm/ruva"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "citrus", "~> 2.4.1"
  gem.add_dependency "indentation-parser"
  
  gem.add_development_dependency "rspec", "~> 2.6"
end
