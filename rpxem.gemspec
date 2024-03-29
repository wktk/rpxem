require File.expand_path('../lib/rpxem/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'rpxem'
  gem.version       = RPxem::VERSION
  gem.authors       = ['k.wakitani']
  gem.email         = ['k.wakitani@gmail.com']

  gem.summary       = %q{Pxem implementation in Ruby}
  gem.description   = %q{rpxem is a Ruby implementation of Pxem, an esoteric programming language that enables you to create programs in 0-byte files.}
  gem.homepage      = 'https://github.com/wktk/rpxem'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.0.0'

  gem.add_dependency 'scanf' if RUBY_VERSION > '2.7'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rspec', '~> 3.8'

  if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create("2.3")
    gem.add_development_dependency 'rake', '~> 13.1'
  else
    gem.add_development_dependency 'rake', '~> 12.3'
  end
end
