module DataPaths
  module Methods
    #
    # The directories registered within a specific module or class.
    #
    # @return [Array<String>]
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
    # @since 0.3.0
    #
    def register_data_path(path)
      DataPaths.register(path)

      data_paths << path unless data_paths.include?(path)
      return path
    end

    #
    # @deprecated Will be removed 1.0.0, please use {#register_data_path}
    #   instead.
    #
    def register_data_dir(path)
      STDERR.puts "DEPRECATED: Please use register_data_path instead."

      register_data_path(path)
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
    # @since 0.3.0
    #
    def unregister_data_path(path)
      path = File.expand_path(path)

      self.data_paths.delete(path)
      return DataPaths.unregister!(path)
    end

    #
    # @deprecated Will be removed 1.0.0, please use {#unregister_data_path}
    #   instead.
    #
    def unregister_data_dir!(path)
      STDERR.puts "DEPRECATED: Please use unregister_data_path instead."

      unregister_data_path(path)
    end

    #
    # Unregisters all previously registered data directories.
    #
    # @return [true]
    #   Specifies all data paths were successfully unregistered.
    #
    # @since 0.3.0
    #
    def unregister_data_paths
      data_paths.each { |path| DataPaths.unregister!(path) }
      data_paths.clear
      return true
    end

    #
    # @deprecated Will be removed 1.0.0, please use {#unregister_data_paths}
    #   instead.
    #
    def unregister_data_dirs!
      STDERR.puts "DEPRECATED: Please use unregister_data_paths instead."

      unregister_data_paths
    end
  end
end
