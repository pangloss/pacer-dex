require 'yaml'

module Pacer
  DexVertex = com.tinkerpop.blueprints.pgm.impls.dex.DexVertex

  # Extend the java class imported from blueprints.
  class DexVertex
    include Pacer::Core::Graph::VerticesRoute
    include ElementMixin
    include VertexMixin
  end
end
