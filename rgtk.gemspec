# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'rgtk/version'

Gem::Specification.new do |s|
  s.name        = 'rgtk'
  s.version     = Rgtk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Semyonov']
  s.email       = ['al@semyonov.us']
  s.homepage    = %q{http://github.com/alsemyonov/rgtk}
  s.summary     = %q{Small framework for Ruby GTK development}
  s.description = %q{Rails-flavoured Ruby GTK framework}

  s.rubyforge_project = 'rgtk'

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activesupport', '~> 3.0.0'
  s.add_dependency 'xdg', '~> 1.0.0'
  s.add_dependency 'ya2yaml', '~> 0.30'
  s.add_dependency 'gtk2', '~> 0.90.8'

  s.add_development_dependency 'yard'
end
