module Prexml
  class NodeList
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

    def replace(old_node, *new_nodes)
      index = @nodes.find_index(old_node)
      replace_at(index, *new_nodes)
    end

    def replace_at(index, *new_nodes)
      old_node = @nodes.delete_at(index)
      old_node.parent = nil

      @nodes.insert(index, *new_nodes[0])
      new_nodes[0].each {|n| n.parent = parent }
    end

    def []=(index, new_node)
      replace(index, new_node)
    end

    def next(current_node)
      index = @nodes.find_index(current_node)

      # If we still have siblings, pick the next one.
      # Otherwise, ask for our parents next sibling
      if index < @nodes.length - 1
        current_node.next_sibling
      else
        current_node.parent.next_sibling
      end
    end

    def next_sibling(current_node)
      index = @nodes.find_index(current_node)
      @nodes[index + 1]
    end

    def previous(current_node)
      index = @nodes.find_index(current_node)

      if index == 0
        current_node.parent
      else
        current_node.previous_sibling
      end
    end

    def previous_sibling(current_node)
      index = @nodes.find_index(current_node)

      if index == 0
        nil
      else
        @nodes[index - 1]
      end
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
      @nodes.inspect
    end

    def ==(other)
      other.is_a?(Prexml::NodeList) &&
        other.nodes == nodes
    end

    private

    def parent
      @parent
    end
  end
end
