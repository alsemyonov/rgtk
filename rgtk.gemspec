# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rgtk}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexander Semyonov"]
  s.date = %q{2009-11-09}
  s.description = %q{Rails-flavoured Ruby GTK framework}
  s.email = %q{rotuka@tokak.ru}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".yardoc",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/rgtk.rb",
     "lib/rgtk/app.rb",
     "lib/rgtk/controller.rb",
     "test/helper.rb",
     "test/test_rgtk.rb"
  ]
  s.homepage = %q{http://github.com/rotuka/rgtk}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Small framework for Ruby GTK development}
  s.test_files = [
    "test/helper.rb",
     "test/test_rgtk.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_runtime_dependency(%q<xdg>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<xdg>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<xdg>, [">= 0"])
  end
end

