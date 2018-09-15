# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rpxem/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'rpxem'
  gem.version       = RPxem::VERSION
  gem.authors       = ['k.wakitani']
  gem.email         = ['k.wakitani@gmail.com']

  gem.summary       = %q{Pxem implementation in Ruby}
  gem.description   = %q{RPxem is a Ruby implementation of Pxem, an esoteric programming language that enables you to create programs in 0-byte files.}
  gem.homepage      = 'https://github.com/wktk/rpxem'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.16'
  gem.add_development_dependency 'rspec', '~> 3.8'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rdoc', '~> 6.0'
end
