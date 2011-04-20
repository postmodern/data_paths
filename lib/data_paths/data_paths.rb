require 'data_paths/methods'

module DataPaths
  include Methods

  def self.included(base)
    base.extend Methods
  end

  #
  # The registered `data/` directories.
  #
  # @return [Set]
  #   The directories which contain static content.
  #
  def DataPaths.paths
    @data_paths ||= []
  end

  #
  # Registers a `data/` directory.
  #
  # @return [String]
  #   The registered `data/` directory.
  #
  # @raise [RuntimeError]
  #   The given path was not a directory.
  #
  # @since 0.3.0
  #
  def DataPaths.register(path)
    path = File.expand_path(path)

    unless File.directory?(path)
      raise("#{path.dump} must be a directory")
    end

    paths << path unless paths.include?(path)
    return path
  end

  #
  # Unregisters a previously registered `data/` directory.
  #
  # @return [String]
  #   The unregistered `data/` directory.
  #
  # @since 0.3.0
  #
  def DataPaths.unregister!(path)
    paths.delete(File.expand_path(path))
  end
end
