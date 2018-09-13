# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rpxem/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['wktk']
  gem.email         = ['wktk@wktk.in']
  gem.description   = %q{RPxem is a Ruby implementation of Pxem, an esoteric programming language that enables you to create programs in 0-byte files.}
  gem.summary       = %q{Pxem implementation in Ruby}
  gem.homepage      = 'https://github.com/wktk/rpxem'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'rpxem'
  gem.require_paths = ['lib']
  gem.version       = RPxem::VERSION

  gem.add_development_dependency 'rspec', '~> 3.8'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdoc'
end
