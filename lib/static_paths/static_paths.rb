require 'static_paths/methods'

require 'set'

module StaticPaths
  include Methods

  def self.included(base)
    base.extend Methods
  end

  #
  # The registered `static/` directories.
  #
  # @return [Set]
  #   The directories which contain static content.
  #
  def StaticPaths.paths
    @@static_paths ||= Set[]
  end
end
