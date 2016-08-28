module Prexml
  class Document

    def initialize(nodes: [])
      @nodes = NodeList.new(self)

      nodes.each {|n| add(n) }
    end

    def nodes
      @nodes
    end

    def children
      @nodes
    end

    def []=(index, node)
      @nodes[index] = node
    end

    def <<(node)
      @nodes.add(node)
    end

    def add(node)
      node.document = self
      @nodes.add(node)
    end

    def ==(other)
      other.is_a?(Prexml::Document) && (other.nodes == nodes)
    end
  end
end
