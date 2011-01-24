require 'set'

module DataPaths
  module Methods
    #
    # The directories registered within a specific module or class.
    #
    # @return [Set]
    #   The directories registered so far.
    #
    def data_paths
      @data_paths ||= Set[]
    end

    #
    # Registers a path as a data directory.
    #
    # @param [String] path
    #   The path to add to {DataPaths.paths}.
    #
    # @return [String]
    #   The fully qualified form of the specified path.
    #
    # @example
    #   register_data_dir File.join(File.dirname(__FILE__),'..','..','..','data')
    #
    # @raise [RuntimeError]
    #   The specified path is not a directory.
    #
    def register_data_dir(path)
      path = File.expand_path(path)

      unless File.directory?(path)
        raise(RuntimeError,"#{path.dump} must be a directory")
      end

      self.data_paths << path

      DataPaths.paths << path
      return path
    end

    #
    # Unregisters any matching data directories.
    #
    # @param [String] path
    #   The path to unregister.
    #
    # @return [true]
    #
    def unregister_data_dir!(path)
      path = File.expand_path(path)

      self.data_paths.reject! { |dir| dir == path }
      DataPaths.paths.reject! { |dir| dir == path }
      return true
    end

    #
    # Unregisters all previously registered data directories.
    #
    # @return [true]
    #
    def unregister_data_dirs!
      DataPaths.paths.reject! { |dir| self.data_paths.include?(dir) }
      self.data_paths.clear
      return true
    end
  end
end
