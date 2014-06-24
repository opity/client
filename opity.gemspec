# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opity/version'

Gem::Specification.new do |spec|
  spec.name          = "opity"
  spec.version       = Opity::Version::STRING
  spec.authors       = ["Shawn Catanzarite"]
  spec.email         = ["me@shawncatz.com"]
  spec.summary       = %q{Opity Client}
  spec.description   = %q{Opity Client}
  spec.homepage      = "http://github.com/opity/client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'clamp', '~> 0.6.3'
  spec.add_dependency 'hashie'
  spec.add_dependency 'activesupport', '~> 4.1.1'
  spec.add_dependency 'require_all', '~> 1.3.2'
  spec.add_dependency 'fog', '1.22.1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
