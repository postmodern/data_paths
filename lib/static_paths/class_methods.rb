module StaticPaths
  module ClassMethods
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

      StaticPaths.paths << path
      return path
    end
  end
end
