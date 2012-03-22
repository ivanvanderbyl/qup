# -*- encoding: utf-8 -*-
require File.expand_path('../lib/qup/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Hinegardner", "Ivan Vanderbyl"]
  gem.email         = ["jeremy@copiousfreetime.org", "ivanvanderbyl@me.com"]
  gem.description   = "AMQP backend for Qup"
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/copiousfreetime/qup"
  gem.date          = "2012-03-22"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "qup-amqp"
  gem.require_paths = ["lib"]
  gem.version       = Qup::VERSION

  gem.add_dependency("uuid", ["~> 2.3.5"])
  gem.add_dependency("hashr", ["~> 0.0.19"])
  gem.add_dependency("amqp", ["~> 0.9.4"])
  gem.add_dependency("bunny", ["~> 0.7.9"])
  gem.add_dependency("qup", [Qup::VERSION])
end
