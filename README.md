# data_paths

* [github.com/postmodern/data_paths](http://github.com/postmodern/data_paths)
* [github.com/postmodern/data_paths/issues](http://github.com/postmodern/data_paths/issues)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

DataPaths is a library to manage the paths of directories containing
static-content across multiple libraries.

For example, DataPaths can manage the `data/` directories of
multiple RubyGems, in much the same way RubyGems manages the paths of
`lib/` directories using `$LOAD_PATH`.

## Features

* Allows libraries to register static-content directories using the
  `register_data_dir` class or instance method.
* Allows libraries to unregister a single path using
  `unregister_data_dir` or all paths registered by that library with
  `unregister_data_dirs`.
* Provides helper methods in {DataPaths::Finders} for searching through
  the registered static-content directories.
* Does not use global variables.

## Examples

Register a directory containing static-content:

    require 'data_paths'
    
    module MyLibrary
      include DataPaths
    
      # define the data dir(s)
      register_data_dir File.join(File.dirname(__FILE__),'..','..','data')
    end

List previously registered static-content directories:

    # all data directories
    DataPaths.paths
    # => #<Set: {...}>

    # the data directories registeed in MyLibrary
    MyLibrary.data_paths
    # => #<Set: {...}>

    # list data directories registered in an object
    lib = MyLibrary.new
    lib.register_data_dir File.join('path','to','data')

    lib.data_paths
    # => #<Set: {...}>

Using {DataPaths::Finders} to access content from within the
static-content directories:

    module MyLibrary
      class UsesContent
    
        include DataPaths::Finders
    
        def index
          find_data_file('index.html')
        end

        def file_dirs
          all_data_dirs('extra')
        end
    
      end
    end

## Install

    $ sudo gem install data_paths

## License

See {file:LICENSE.txt} for license information.

