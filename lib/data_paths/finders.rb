require 'data_paths/data_paths'

require 'yaml'

module DataPaths
  module Finders
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
    # Loads the YAML file at the given path, within any data directory.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @return [Object]
    #   The contents of the YAML file.
    #
    # @since 0.3.0
    #
    def load_yaml_file(path)
      if (file = find_data_file(path))
        YAML.load_file(file)
      end
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
    # @return [Enumerator]
    #   If no block is given, an Enumerator object will be returned.
    #
    def each_data_file(path)
      return enum_for(:each_data_file,path) unless block_given?

      each_data_path(path) do |full_path|
        yield(full_path) if File.file?(full_path)
      end
    end

    #
    # Finds all occurrences of a given file path, within all data
    # directories.
    #
    # @param [String] path
    #   The file path to search for.
    #
    # @return [Array]
    #   The loaded YAML files.
    #
    # @since 0.3.0
    #
    def load_yaml_files(path)
      each_data_file.map { |file| YAML.load_file(file) }
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
    # @return [Enumerator]
    #   If no block is given, an Enumerator object will be returned.
    #
    def each_data_dir(path)
      return enum_for(:each_data_dir,path) unless block_given?

      each_data_path(path) do |full_path|
        yield(full_path) if File.directory?(full_path)
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
    # @yield [path]
    #   If a block is given, it will be passed every matching path.
    #
    # @yieldparam [String] path
    #   The path of a matching file within a data directory.
    #
    # @return [Array<String>]
    #   If no block is given, the matching paths found within all data
    #   directories will be returned.
    #
    # @since 0.3.0
    #
    def glob_data_paths(pattern,&block)
      return enum_for(:glob_data_paths,pattern).to_a unless block_given?

      DataPaths.paths.each do |path|
        Dir.glob(File.join(path,pattern),&block)
      end
    end

    #
    # @deprecated
    #   Will be removed in 1.0.0, please use {#glob_data_paths} instead.
    #
    def data_glob(pattern)
      STDERR.puts "DEPRECATED: please use glob_data_paths instead."

      glob_data_paths(pattern)
    end
  end
end
