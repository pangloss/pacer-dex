require 'yaml'

module Pacer
  DexGraph = com.tinkerpop.blueprints.pgm.impls.dex.DexGraph
  DexElement = com.tinkerpop.blueprints.pgm.impls.dex.DexElement

  # Add 'static methods' to the Pacer namespace.
  class << self
    # Return a graph for the given path. Will create a graph if none exists at
    # that location. (The graph is only created if data is actually added to it).
    def dex(path)
      path = File.expand_path(path)
      Pacer.starting_graph(self, path) do
        DexGraph.new(path)
      end
    end
  end


  # Extend the java class imported from blueprints.
  class DexGraph
    include GraphMixin
    include GraphTransactionsStub
    include ManagedTransactionsMixin
    include Pacer::Core::Route
    include Pacer::Core::Graph::GraphRoute

    # Override to return an enumeration-friendly array of vertices.
    def get_vertices
      getVertices.to_enum(:map).to_route(:graph => self, :element_type => :vertex)
    end

    # Override to return an enumeration-friendly array of edges.
    def get_edges
      getEdges.to_enum(:map).to_route(:graph => self, :element_type => :edge)
    end

    def element_type(et = nil)
      return nil unless et
      if et == DexVertex or et == DexEdge or et == DexElement
        et
      else
        case et
        when :vertex, com.tinkerpop.blueprints.pgm.Vertex, VertexMixin
          DexVertex
        when :edge, com.tinkerpop.blueprints.pgm.Edge, EdgeMixin
          DexEdge
        when :mixed, com.tinkerpop.blueprints.pgm.Element, ElementMixin
          DexElement
        when :object
          Object
        else
          if et == Object
            Object
          elsif et == DexVertex.java_class.to_java
            DexVertex
          elsif et == DexEdge.java_class.to_java
            DexEdge
          elsif et == index_class(:vertex)
            DexVertex
          else
            raise ArgumentError, 'Element type may be one of :vertex or :edge'
          end
        end
      end
    end

    def index_class(et = nil)
      if element_type(et) == DexVertex
        com.tinkerpop.blueprints.pgm.Vertex.java_class
      end
    end

    def sanitize_properties(props)
      pairs = props.map do |name, value|
        [name, encode_property(value)]
      end
      Hash[pairs]
    end

    def encode_property(value)
      case value
      when nil
        nil
      when String
        value = value.strip
        value unless value == ''
      when Fixnum
        int = java.lang.Integer
        if value > int::MIN_VALUE and value < int::MAX_VALUE
          value.to_java(:int)
        else
          value.to_yaml
        end
      when Numeric
        if value.is_a? Bignum
          value.to_yaml
        else
          value
        end
      when true, false
        value.to_java
      else
        value.to_yaml
      end
    end

    if RUBY_VERSION =~ /^1.9/
      def decode_property(value)
        if value.is_a? String and value[0, 5] == '%YAML'
          YAML.load(value)
        else
          value
        end
      end
    else
      def decode_property(value)
        if value.is_a? String and value[0, 3] == '---'
          YAML.load(value)
        else
          value
        end
      end
    end

    def supports_custom_element_ids?
      false
    end

    def supports_automatic_indices?
      false
    end

    def supports_manual_indices?
      false
    end

    def supports_edge_indices?
      false
    end
  end
end
