class RSpec::GraphRunner
  module Dex
    def all(usage_style = :read_write, indices = true, &block)
      super
      dex(usage_style, indices, &block)
    end

    def dex(usage_style = :read_write, indices = true, &block)
      for_graph('dex', usage_style, indices, false, dex_graph, dex_graph2, nil, block)
    end

    protected

    def dex_graph
      return @dex_graph if @dex_graph
      path1 = File.expand_path('tmp/spec.dex')
      dir = Pathname.new(path1)
      dir.rmtree if dir.exist?
      @dex_graph = Pacer.dex(path1)
    end

    def dex_graph2
      return @dex_graph2 if @dex_graph2
      path2 = File.expand_path('tmp/spec.dex.2')
      dir = Pathname.new(path2)
      dir.rmtree if dir.exist?
      @dex_graph2 = Pacer.dex(path2)
    end
  end

  include Dex
end
