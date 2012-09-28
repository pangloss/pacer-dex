module Pacer
  class << self
    # Return a graph for the given path. Will create a graph if none exists at
    # that location. (The graph is only created if data is actually added to it).
    def dex(path)
      dex = com.tinkerpop.blueprints.impls.dex.DexGraph
      path = File.expand_path(path)
      open = proc do
        graph = Pacer.open_graphs[path]
        unless graph
          graph = dex.new(path)
          Pacer.open_graphs[path] = graph
        end
        graph
      end
      shutdown = proc do |g|
        g.blueprints_graph.shutdown
        Pacer.open_graphs.delete path
      end
      PacerGraph.new(Pacer::Dex::Encoder, open, shutdown)
    end
  end
end
