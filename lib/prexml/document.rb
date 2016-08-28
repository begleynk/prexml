module Prexml
  class Document

    def initialize(nodes: [])
      @nodes = nodes
    end

    def nodes
      @nodes
    end

    def <<(node)
      add(node)
    end

    def add(node)
      @nodes.concat([node])
    end

    def ==(other)
      other.is_a?(Prexml::Document) && (other.nodes == nodes)
    end
  end
end
