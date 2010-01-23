require 'static_paths/static_paths'

module StaticPaths
  module Finders
    #
    # Passes all possible static paths for the specified path,
    # within the static directories, to the given block.
    #
    # @param [String] path
    #   The path to search for within all static directories.
    #
    # @yield [potential_path]
    #   The given block will be passed every possible combination of the
    #   given path and the static directories.
    #
    # @yieldparam [String] potential_path
    #   A potentially valid path.
    #
    def each_static_path(path,&block)
      StaticPaths.paths.each do |dir|
        block.call(File.join(dir,path))
      end
    end

    #
    # Searches for the given path within any static directory.
    #
    # @param [String] path
    #   The path to search for.
    #
    # @return [String, nil]
    #   Returns the first valid match for the given path within a static
    #   directory. Returns +nil+ if the given path could not be found
    #   in any static directory.
    #
    def find_static_path(path)
      each_static_path(path) do |full_path|
        return full_path if File.exists?(full_path)
      end

      return nil
    end

    #
    # Searches for a file at the given path, within any static directory.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @return [String, nil]
    #   Returns the first valid file at the given path within a static
    #   directory. Returns +nil+ if the given path could not be found
    #   in any static directory.
    #
    def find_static_file(path)
      each_static_path(path) do |full_path|
        return full_path if File.file?(full_path)
      end

      return nil
    end

    #
    # Searches for a directory at the given path, within any static
    # directory.
    #
    # @param [String] path
    #   The directory path to search for.
    #
    # @return [String, nil]
    #   Returns the first valid directory at the given path within a
    #   static directory. Returns +nil+ if the given path could not be
    #   found in any static directory.
    #
    def find_static_dir(path)
      each_static_path(path) do |full_path|
        return full_path if File.directory?(full_path)
      end

      return nil
    end

    #
    # Searches for the first set of paths that match the given pattern,
    # within any static directory.
    #
    # @param [String] pattern
    #   The path glob pattern to search with.
    #
    # @return [Array<String>]
    #   The Array of paths that match the given pattern within a static
    #   directory.
    #
    def static_glob(pattern)
      each_static_path(pattern) do |full_path|
        paths = Dir[full_path]

        return paths unless paths.empty?
      end

      return []
    end

    #
    # Finds all occurrences of a given path, within all static
    # directories.
    #
    # @param [String] path
    #   The path to search for.
    #
    # @return [Array<String>]
    #   The occurrences of the given path within all static directories.
    #
    def all_static_paths(path)
      paths = []

      each_static_path(path) do |full_path|
        paths << full_path if File.exists?(full_path)
      end

      return paths
    end

    #
    # Finds all occurrences of a given path, within all static
    # directories.
    #
    # @param [String] path
    #   The path to search for.
    #
    # @yield [static_path]
    #   If a block is given, it will be passed every found path.
    #
    # @yieldparam [String] static_path
    #   A path within a static directory.
    #
    # @return [Array<String>]
    #   The occurrences of the given path within all static directories.
    #
    def each_static_path(path,&block)
      all_static_paths(path).each(&block)
    end

    #
    # Finds all occurrences of a given file path, within all static
    # directories.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @return [Array<String>]
    #   The occurrences of the given file path within all static
    #   directories.
    #
    def find_static_files(path)
      paths = []

      each_static_path(path) do |full_path|
        paths << full_path if File.file?(full_path)
      end

      return paths
    end

    #
    # Finds all occurrences of a given file path, within all static
    # directories.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @yield [static_file]
    #   If a block is given, it will be passed every found path.
    #
    # @yieldparam [String] static_file
    #   The path of a file within a static directory.
    #
    # @return [Array<String>]
    #   The occurrences of the given file path within all static
    #   directories.
    #
    def each_static_file(path,&block)
      find_static_files(path).each(&block)
    end

    #
    # Finds all occurrences of a given directory path, within all static
    # directories.
    #
    # @param [String] path
    #   The directory path to search for.
    #
    # @return [Array<String>]
    #   The occurrences of the given directory path within all static
    #   directories.
    #
    def find_static_dirs(path)
      paths = []

      each_static_path(path) do |full_path|
        paths << full_path if File.directory?(full_path)
      end

      return paths
    end

    #
    # Finds all occurrences of a given directory path, within all static
    # directories.
    #
    # @param [String] path
    #   The directory path to search for.
    #
    # @yield [static_dir]
    #   If a block is given, it will be passed every found path.
    #
    # @yieldparam [String] static_dir
    #   The path of a directory within a static directory.
    #
    # @return [Array<String>]
    #   The occurrences of the given directory path within all static
    #   directories.
    #
    def each_static_dir(path,&block)
      find_static_dirs(path).each(&block)
    end

    #
    # Finds all paths that match a given pattern, within all static
    # directories.
    #
    # @param [String] pattern
    #   The path glob pattern to search with.
    #
    # @return [Array<String>]
    #   The matching paths found within all static directories.
    #
    def static_glob_all(pattern)
      paths = []

      each_static_path(pattern) do |full_path|
        paths += Dir[full_path]
      end

      return paths
    end
  end
end
