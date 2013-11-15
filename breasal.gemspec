# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'breasal/version'

Gem::Specification.new do |spec|
  spec.name          = "breasal"
  spec.version       = Breasal::VERSION
  spec.authors       = ["Stuart Harrison"]
  spec.email         = ["stuart.harrison@theodi.org"]
  spec.description   = %q{A Ruby gem that converts both British and Irish Eastings and northing to WGS84 latitude and longitude}
  spec.homepage      = "https://github.com/theodi/breasal"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov-rcov"
end
