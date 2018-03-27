lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'site_search/version'

Gem::Specification.new do |spec|
  spec.name          = 'site_search'
  spec.version       = SiteSearch::VERSION
  spec.authors       = ["Tomas D'Stefano"]
  spec.email         = ['development.team@moneyadviceservice.org.uk']
  spec.summary       = %(Site search is a library which enable to connect
                       to many services to do the site search.)
  spec.description = %(Site search is a library which enable to connect
                       to many services to do the site search.)
  spec.homepage      = 'https://github.com/moneyadviceservice/site_search/'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'algoliasearch'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
