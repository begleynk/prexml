module Prexml
  class Document

    def initialize(nodes: [])
      @nodes = []

      nodes.each {|n| add(n) }
    end

    def nodes
      @nodes
    end

    def <<(node)
      add(node)
    end

    def add(node)
      node.document = self
      @nodes.concat([node])
    end

    def ==(other)
      other.is_a?(Prexml::Document) && (other.nodes == nodes)
    end
  end
end
