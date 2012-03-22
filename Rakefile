#!/usr/bin/env rake
# require 'bundler/gem_helper'
# Bundler::GemHelper.install_tasks(:name => 'qup')

desc 'Build gem into the pkg directory'
task :build do
  FileUtils.rm_rf('pkg')
  Dir['*.gemspec'].each do |gemspec|
    system "gem build #{gemspec}"
  end
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

desc 'Tags version, pushes to remote, and pushes gem'
task :release => :build do
  sh 'git', 'tag', '-m', changelog, "v#{Qup::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{Qup::VERSION}"
  sh "ls pkg/*.gem | xargs -n 1 gem push"
end

require 'rspec/core/rake_task'

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
  t.verbose = false
end

desc "Run all specs"
task :test => :spec

namespace :spec do
  require 'qup'
  Qup::KNOWN_ADAPTERS.each do |backend, gem|
    desc "Run specs for #{backend} backend"
    RSpec::Core::RakeTask.new(backend) do |t|
      t.rspec_opts = ['--color', "-t #{backend}"]
      t.verbose = false
    end
  end
end

task :default => :spec
