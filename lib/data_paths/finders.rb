require 'data_paths/data_paths'

require 'enumerator'

module DataPaths
  module Finders
    include Enumerable

    #
    # Passes all existing data paths for the specified path,
    # within the data directories, to the given block.
    #
    # @param [String] path
    #   The path to search for in all data directories.
    #
    # @yield [potential_path]
    #   The given block will be passed every existing combination of the
    #   given path and the data directories.
    #
    # @yieldparam [String] potential_path
    #   An existing data path.
    #
    # @return [Enumerator]
    #   If no block is given, an Enumerator object will be returned.
    #
    def each_data_path(path)
      return enum_for(:each_data_path,path) unless block_given?

      DataPaths.paths.each do |dir|
        full_path = File.join(dir,path)

        yield(full_path) if File.exists?(full_path)
      end
    end

    #
    # Searches for the given path within any data directory.
    #
    # @param [String] path
    #   The path to search for.
    #
    # @return [String, nil]
    #   Returns the first valid match for the given path within a data 
    #   directory. Returns `nil` if the given path could not be found
    #   in any data directory.
    #
    def find_data_path(path)
      each_data_path(path).first
    end

    #
    # Searches for a file at the given path, within any data directory.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @return [String, nil]
    #   Returns the first valid file at the given path within a data
    #   directory. Returns `nil` if the given path could not be found
    #   in any data directory.
    #
    def find_data_file(path)
      each_data_path(path).find { |full_path| File.file?(full_path) }
    end

    #
    # Searches for a directory at the given path, within any data
    # directory.
    #
    # @param [String] path
    #   The directory path to search for.
    #
    # @return [String, nil]
    #   Returns the first valid directory at the given path within a
    #   data directory. Returns `nil` if the given path could not be
    #   found in any data directory.
    #
    def find_data_dir(path)
      each_data_path(path).find { |full_path| File.directory?(full_path) }
    end

    #
    # Finds all occurrences of a given path, within all data directories.
    #
    # @param [String] path
    #   The path to search for.
    #
    # @return [Array<String>]
    #   The occurrences of the given path within all data directories.
    #
    def all_data_paths(path)
      each_data_path(path).to_a
    end

    #
    # Finds all occurrences of a given file path, within all data
    # directories.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @yield [data_file]
    #   If a block is given, it will be passed every found path.
    #
    # @yieldparam [String] data_file
    #   The path of a file within a data directory.
    #
    # @return [Array<String>]
    #   The occurrences of the given file path within all data
    #   directories.
    #
    def each_data_file(path)
      each_data_path(path) do |full_path|
        block.call(full_path) if File.file?(full_path)
      end
    end

    #
    #
    # Finds all occurrences of a given file path, within all data
    # directories.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @return [Array<String>]
    #   The occurrences of the given file path within all data
    #   directories.
    #
    def all_data_files(path)
      each_data_file(path).to_a
    end

    #
    # Finds all occurrences of a given directory path, within all data
    # directories.
    #
    # @param [String] path
    #   The directory path to search for.
    #
    # @yield [data_dir]
    #   If a block is given, it will be passed every found path.
    #
    # @yieldparam [String] data_dir
    #   The path of a directory within a data directory.
    #
    # @return [Array<String>]
    #   The occurrences of the given directory path within all data
    #   directories.
    #
    def each_data_dir(path,&block)
      each_data_path(path) do |full_path|
        block.call(full_path) if File.directory?(full_path)
      end
    end

    #
    # Finds all occurrences of a given directory path, within all data
    # directories.
    #
    # @param [String] path
    #   The directory path to search for.
    #
    # @return [Array<String>]
    #   The occurrences of the given directory path within all data
    #   directories.
    #
    def all_data_dirs(path)
      each_data_dir(path).to_a
    end

    #
    # Finds all paths that match a given pattern, within all data
    # directories.
    #
    # @param [String] pattern
    #   The path glob pattern to search with.
    #
    # @return [Array<String>]
    #   The matching paths found within all data directories.
    #
    def data_glob(pattern)
      paths = []

      DataPaths.paths.each do |path|
        paths += Dir[File.join(path,pattern)]
      end

      return paths
    end
  end
end
