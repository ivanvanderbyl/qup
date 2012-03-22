# -*- encoding: utf-8 -*-
require File.expand_path('../lib/qup/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Hinegardner", "Ivan Vanderbyl"]
  gem.email         = ["jeremy@copiousfreetime.org", "ivanvanderbyl@me.com"]
  gem.description   = "Maildir backend for Qup"
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/copiousfreetime/qup"
  gem.date          = "2012-03-22"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "qup-maildir"
  gem.require_paths = ["lib"]
  gem.version       = Qup::VERSION

  gem.add_dependency("maildir", ["~> 2.0.0"])
  gem.add_dependency("qup", [Qup::VERSION])
end
