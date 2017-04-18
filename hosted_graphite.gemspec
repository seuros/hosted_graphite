lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hosted_graphite/version'

Gem::Specification.new do |spec|
  spec.name          = 'hosted_graphite'
  spec.version       = HostedGraphite::VERSION
  spec.authors       = ['Abdelkader Boudih']
  spec.email         = ['terminale@gmail.com']
  spec.summary       = 'A Ruby client for HostedGraphite'
  spec.homepage      = 'https://github.com/seuros/hosted_graphite'
  spec.license       = 'Apache 2.0'
  spec.required_ruby_version     = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.6.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.4'
  spec.add_dependency 'statsd-ruby', '~> 1.2.1'
end
