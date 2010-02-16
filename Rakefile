require 'rubygems'
require 'rake'
require './lib/static_paths/version.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'static_paths'
    gem.version = StaticPaths::VERSION
    gem.summary = %Q{StaticPaths is a library to manage the paths of directories containing static-content across multiple libraries.}
    gem.description = %Q{StaticPaths is a library to manage the paths of directories containing static-content across multiple libraries. For example, StaticPaths can manage the `static/` directories of multiple RubyGems, in much the same way RubyGems manages the paths of `lib/` directories using `$LOAD_PATH`.}
    gem.email = 'postmodern.mod3@gmail.com'
    gem.homepage = 'http://github.com/postmodern/static_paths'
    gem.authors = ['Postmodern']
    gem.add_development_dependency 'rspec', '>= 1.3.0'
    gem.add_development_dependency 'yard', '>= 0.5.3'
    gem.has_rdoc = 'yard'
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :spec => :check_dependencies
task :default => :spec

begin
  require 'yard'

  YARD::Rake::YardocTask.new
rescue LoadError
  task :yard do
    abort "YARD is not available. In order to run yard, you must: gem install yard"
  end
end
