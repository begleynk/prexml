require 'prexml/node/attribute_list'

module Prexml
  class Node

    def initialize(name: nil, value: nil, attributes: {}, children: [])
      if value && children.any?
        raise InvalidNode, 'Node cannot have child nodes and a value' 
      end

      @name        = name
      @attributes  = AttributeList.new(self, attributes)
      @child_nodes = NodeList.new(self, children)
      @value       = value
      @parent      = nil
    end

    def name
      @name
    end

    def name=(new_name)
      @name = new_name
    end

    def value
      @value
    end

    def value=(new_value)
      @value = new_value
    end

    def attributes
      @attributes
    end

    def children
      @child_nodes
    end

    def parent
      @parent
    end

    def parent=(node)
      @parent = node
    end

    def document
      # Traverse the tree to the root, and if the root belongs
      # to a document, return that. If not, return nil.
      if @document.nil?
        parent.document unless parent.nil?
      else
        @document
      end
    end

    def document=(doc)
      raise 'Invalid Document' unless doc.is_a?(Prexml::Document)
      @parent = doc if root?
      @document = doc
    end

    def replace(*new_nodes)
      if parent
        parent.children.replace(self, new_nodes)
      else
        raise 'Cannot replace node with no parent. Use assignment instead.'
      end
    end

    def root?
      parent.nil? || parent.is_a?(Prexml::Document)
    end

    def root
      if parent.nil?
        self
      else
        next_parent = parent.root
        while next_parent.root.nil?
          next_parent = parent.root
        end
        next_parent
      end
    end

    def ==(other_node)
      other_node.is_a?(Prexml::Node) &&
        other_node.attributes == attributes &&
        other_node.children   == children &&
        other_node.value      == value &&
        other_node.parent     == parent
    end

    def inspect
      "#<Prexml::Node @name=#{name.inspect} @attributes=#{attributes.inspect} @children=#{children.inspect}>"
    end
  end
end
