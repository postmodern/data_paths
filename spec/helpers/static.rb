require 'static_paths/static_paths'

module Helpers
  include StaticPaths

  STATIC_DIRS = [
    File.expand_path(File.join(File.dirname(__FILE__),'static1')),
    File.expand_path(File.join(File.dirname(__FILE__),'static2')),
  ]

  STATIC_DIRS.each { |dir| register_static_dir dir }
end
