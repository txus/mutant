# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mutant/version"

Gem::Specification.new do |s|
  s.name        = 'mutant'
  s.version     = Mutant::VERSION
  s.authors     = ["Justin Ko", "Josep M. Bach"]
  s.email       = ["justin@kospecinc.com", "josep.m.bach@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Mutation tester}
  s.description = %q{Mutation tester}

  s.rubyforge_project = "mutant"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.bindir        = 'exe'
  s.executables   = `git ls-files -- exe/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'to_source'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'aruba'
end
