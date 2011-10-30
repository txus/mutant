# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heckle/version"

Gem::Specification.new do |s|
  s.name        = "heckle"
  s.version     = Heckle::VERSION
  s.authors     = ["Justin Ko"]
  s.email       = ["jko170@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "heckle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'aruba'
end
