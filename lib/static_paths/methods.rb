require 'set'

module StaticPaths
  module Methods
    #
    # The registered static directories.
    #
    # @return [Set]
    #   The directories registered so far.
    #
    def static_paths
      @static_paths ||= Set[]
    end

    #
    # Registers a path as a static directory.
    #
    # @param [String] path
    #   The path to add to {StaticPaths.paths}.
    #
    # @return [String]
    #   The fully qualified form of the specified path.
    #
    # @example
    #   static_dir File.join(File.dirname(__FILE__),'..','..','..','static')
    #
    # @raise [RuntimeError]
    #   The specified path is not a directory.
    #
    def static_dir(path)
      path = File.expand_path(path)

      unless File.directory?(path)
        raise(RuntimeError,"#{path.dump} must be a directory")
      end

      self.static_paths << path

      StaticPaths.paths << path
      return path
    end

    #
    # Unregisters any matching static directories.
    #
    # @param [String] path
    #   The path to unregistere.
    #
    # @return [true]
    #
    def unregister_static_dir!(path)
      path = File.expand_path(path)

      self.static_paths.reject! { |dir| dir == path }
      StaticPaths.reject! { |dir| dir == path }
      return true
    end

    #
    # Unregisters all previously registered static directories.
    #
    # @return [true]
    #
    def unregister_static_dirs!
      StaticPaths.reject! { |dir| self.static_paths.include?(dir) }
      self.static_paths.clear
      return true
    end
  end
end
