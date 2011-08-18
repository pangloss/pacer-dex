# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pacer-dex/version"

Gem::Specification.new do |s|
  s.name        = "pacer-dex"
  s.version     = Pacer::Dex::VERSION
  s.platform    = 'jruby'
  s.authors     = ["Darrick Wiebe"]
  s.email       = ["darrick@innatesoftware.com"]
  s.homepage    = "http://sparsity-technologies.com"
  s.summary     = %q{Dex jars and related code for Pacer}
  s.description = s.summary

  s.add_dependency 'pacer'

  s.rubyforge_project = "pacer-dex"

  s.files         = `git ls-files`.split("\n") + [Pacer::Dex::JAR_PATH]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
