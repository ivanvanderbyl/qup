# -*- encoding: utf-8 -*-
require File.expand_path('../lib/qup/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Hinegardner", "Ivan Vanderbyl"]
  gem.email         = ["jeremy@copiousfreetime.org", "ivanvanderbyl@me.com"]
  gem.description   = "Redis backend for Qup"
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/copiousfreetime/qup"
  gem.date          = "2012-03-22"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "qup-redis"
  gem.require_paths = ["lib"]
  gem.version       = Qup::VERSION

  gem.add_dependency("redis", ["~> 2.2.2"])
  gem.add_dependency("qup", [Qup::VERSION])
end
