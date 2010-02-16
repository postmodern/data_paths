# static_paths

* http://static-paths.rubyforge.org/
* http://github.com/postmodern/static_paths
* http://github.com/postmodern/static_paths/issues
* Postmodern (postmodern.mod3 at gmail.com)

## DESCRIPTION:

StaticPaths is a library to manage the paths of directories containing
static-content across multiple libraries.

For example, StaticPaths can manage the `static/` directories of
multiple RubyGems, in much the same way RubyGems manages the paths of
`lib/` directories using `$LOAD_PATH`.

## FEATURES:

* Allows libraries to register static-content directories using the
  `register_static_dir` class or instance method.
* Allows libraries to unregister a single path using
  `unregister_static_dir` or all paths registered by that library with
  `unregister_static_dirs`.
* Provides helper methods in {StaticPaths::Finders} for searching through
  the registered static-content directories.
* Does not use global variables.

## EXAMPLES:

Register a directory containing static-content:

    require 'static_paths'
    
    module MyLibrary
      include StaticPaths
    
      # define the static dir(s)
      register_static_dir File.join(File.dirname(__FILE__),'..','..','static')
    end

List previously registered static-content directories:

    # all static directories
    StaticPaths.paths
    # => #<Set: {...}>

    # the static directories registeed in MyLibrary
    MyLibrary.static_paths
    # => #<Set: {...}>

    # list static directories registered in an object
    lib = MyLibrary.new
    lib.register_static_dir File.join('path','to','static')

    lib.static_paths
    # => #<Set: {...}>

Using {StaticPaths::Finders} to access content from within the
static-content directories:

    module MyLibrary
      class UsesContent
    
        include StaticPaths::Finders
    
        def index
          find_static_file('index.html')
        end

        def file_dirs
          all_static_dirs('extra')
        end
    
      end
    end

## INSTALL:

    $ sudo gem install static_paths

## LICENSE:

See {file:LICENSE.txt} for license information.

