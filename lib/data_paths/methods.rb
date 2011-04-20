module DataPaths
  module Methods
    #
    # The directories registered within a specific module or class.
    #
    # @return [Set]
    #   The directories registered so far.
    #
    def data_paths
      @data_paths ||= []
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
      DataPaths.register(path)

      data_paths << path unless data_paths.include?(path)
      return path
    end

    #
    # Unregisters any matching data directories.
    #
    # @param [String] path
    #   The path to unregister.
    #
    # @return [String]
    #   The unregistered data path.
    #
    def unregister_data_dir!(path)
      path = File.expand_path(path)

      self.data_paths.delete(path)
      return DataPaths.unregister!(path)
    end

    #
    # Unregisters all previously registered data directories.
    #
    # @return [true]
    #
    def unregister_data_dirs!
      data_paths.each { |path| DataPaths.unregister!(path) }
      data_paths.clear
      return true
    end
  end
end
