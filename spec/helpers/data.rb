require 'data_paths/data_paths'

module Helpers
  include DataPaths

  DATA_DIRS = [
    File.expand_path(File.join(File.dirname(__FILE__),'data1')),
    File.expand_path(File.join(File.dirname(__FILE__),'data2')),
  ]

  DATA_DIRS.each { |dir| register_data_dir dir }
end
