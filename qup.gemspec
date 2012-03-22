# -*- encoding: utf-8 -*-
require File.expand_path('../lib/qup/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Hinegardner", "Ivan Vanderbyl"]
  gem.email         = ["jeremy@copiousfreetime.org", "ivanvanderbyl@me.com"]
  gem.description   = "Qup is a generalized API for Message Queue and Publish/Subscribe messaging patterns with the ability to plug in an appropriate messaging infrastructure based upon your needs. Qup ships with support for Kestrel, Redis, and a filesystem infrastructure based on Maildir. Additional Adapters will be developed as needs arise. Please submit an Issue to have a new Adapter created. Pull requests gladly accepted."
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/copiousfreetime/qup"
  gem.date          = "2012-03-22"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "qup"
  gem.require_paths = ["lib"]
  gem.version       = Qup::VERSION

  gem.add_dependency("uuid", ["~> 2.3.5"])
  gem.add_dependency("hashr", ["~> 0.0.19"])
  gem.add_dependency("maildir", ["~> 2.0.0"])
  gem.add_dependency("kestrel-client", ["~> 0.7.1"])
  gem.add_dependency("redis", ["~> 2.2.2"])
  gem.add_dependency("amqp", ["~> 0.9.4"])

  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_development_dependency('rspec', '~> 2.8.0')
  gem.add_development_dependency('simplecov', '~> 0.6.1')
end
