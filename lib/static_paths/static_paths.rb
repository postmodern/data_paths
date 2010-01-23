require 'static_paths/class_methods'

require 'set'

module StaticPaths
  def self.included(base)
    base.extend ClassMethods
  end

  #
  # The registered <tt>static/</tt> directories.
  #
  # @return [Set]
  #   The directories which contain static content.
  #
  def StaticPaths.paths
    @@static_paths ||= Set[]
  end
end
