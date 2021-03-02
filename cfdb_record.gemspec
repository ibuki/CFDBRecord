# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'cfdb_record'
  spec.version       = '0.1.0'
  spec.authors       = ['Ibuki Nakamura']
  spec.email         = ['ibuki.nakamura@reapra.sg']

  spec.summary       = 'Get data from Wordpress CFDB Plugin using ActiveRecord'
  spec.description   = 'Get data from Wordpress CFDB Plugin using ActiveRecord'
  spec.homepage      = 'https://github.com/ibuki/CFDBRecord'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_dependency 'activerecord', '>= 5.2', '< 7.0'
  spec.add_dependency 'kintone', '0.1.5'
end
