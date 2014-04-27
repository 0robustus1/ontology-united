# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ontology-united/version'

Gem::Specification.new do |spec|
  spec.name          = "ontology-united"
  spec.version       = OntologyUnited::VERSION
  spec.authors       = ["Tim Reddehase"]
  spec.email         = ["robustus@rightsrestricted.com"]
  spec.summary       = %q{small ontology definition dsl}
  spec.description   = %q{a small domain specific language for writing owl based ontologies}
  spec.homepage      = "https://github.com/0robustus1/ontology-united"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.5.3", "< 1.7.0"
  spec.add_development_dependency "rake", "~> 10.2"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "simplecov", "~> 0.7.1"
  spec.add_development_dependency "coveralls", "~> 0.7.0"
end
