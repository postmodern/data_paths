require 'data_paths/methods'

require 'set'

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
    @@data_paths ||= Set[]
  end
end
