module Prexml
  class Node
    class Children
      include Enumerable

      def initialize(parent, initial_nodes = [])
        @nodes  = []
        @parent = parent

        initial_nodes.each {|n| add(n) }
      end

      def add(child_node)
        # Set the child's parent node
        child_node.parent = parent
        nodes.concat([child_node])
      end

      def <<(child_node)
        add(child_node)
      end

      def nodes
        @nodes
      end

      def each(&block)
        @nodes.each do |n|
          yield n if block_given?
        end
      end

      def length
        count
      end

      def inspect
        "#<Prexml::Node::Children @nodes=#{@nodes.inspect}"
      end

      def ==(other)
        other.is_a?(Prexml::Node::Children) &&
        other.nodes == nodes
      end

      private

      def parent
        @parent
      end
    end
  end
end
