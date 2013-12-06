# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jrb/version"

Gem::Specification.new do |s|
  s.name        = "jrb"
  s.version     = JRB::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rolf Timmermans"]
  s.email       = ["rolftimmermans@voormedia.com"]
  s.homepage    = "https://github.com/voormedia/jrb"
  s.summary     = %q{JRB templates are Just Ruby}
  s.description = %q{JRB is a trivial templating engine that allows you to use plain Ruby files as templates.}

  s.rubyforge_project = "jrb"

  s.add_dependency("tilt", ["~> 1.3"])
  s.add_development_dependency("rails", ["~> 4.0"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
