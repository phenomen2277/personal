# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'personal/version'

Gem::Specification.new do |spec|
  spec.name          = "personal"
  spec.version       = Personal::VERSION
  spec.authors       = ["Jone Samra"]
  spec.email         = ["jonemob@gmail.com"]

  spec.summary       = %q{A personal diary console application.}
  spec.description   = %q{personal: is a command line diary application written in ruby and distributed as a gem. With personal, you will be able to save, edit and list the diary entries through the terminal. }
  spec.homepage      = "https://github.com/phenomen2277/personal"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["personal"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_runtime_dependency "sqlite3", "~> 1.3.11"
  spec.add_runtime_dependency "thor", "~> 0.19.1"
  spec.add_runtime_dependency "colorize", "~> 0.7.7"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
