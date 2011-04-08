class Rspec::GraphRunner
  module Dex
    def initialize(*graphs)
      super
      if use_graph?('dex')
        path1 = File.expand_path('tmp/spec.dex')
        dir = Pathname.new(path1)
        dir.rmtree if dir.exist?
        @dex_graph = Pacer.dex(path1)

        path2 = File.expand_path('tmp/spec.dex.2')
        dir = Pathname.new(path2)
        dir.rmtree if dir.exist?
        @dex_graph2 = Pacer.dex(path2)
      end
    end

    def all(usage_style = :read_write, indices = true, &block)
      super
      dex(usage_style, indices, &block)
    end

    def dex(usage_style = :read_write, indices = true, &block)
      for_graph('dex', usage_style, indices, false, @dex_graph, @dex_graph2, nil, block)
    end
  end

  include Dex
end
