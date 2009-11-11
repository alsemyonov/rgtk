require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'rgtk'
    gem.summary = %Q{Small framework for Ruby GTK development}
    gem.description = %Q{Rails-flavoured Ruby GTK framework}
    gem.email = 'rotuka@tokak.ru'
    gem.homepage = 'http://github.com/rotuka/rgtk'
    gem.authors = ['Alexander Semyonov']
    gem.add_development_dependency 'thoughtbot-shoulda', '>= 0'
    gem.add_development_dependency 'yard', '>= 0'
    gem.add_dependency 'activesupport', '>= 2.3.4'
    gem.add_dependency 'xdg', '0.5.2'
    gem.add_dependency 'ya2yaml'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

desc "Bump gem version, release and install"
task :push => %w(version:bump:patch release gemcutter:release install)
