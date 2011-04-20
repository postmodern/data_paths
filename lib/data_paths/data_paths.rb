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

  def DataPaths.register(path)
    path = File.expand_path(path)

    unless File.directory?(path)
      raise(RuntimeError,"#{path.dump} must be a directory")
    end

    paths << path unless paths.include?(path)
    return path
  end

  def DataPaths.unregister!(path)
    paths.delete(File.expand_path(path))
  end
end
