require 'prexml/parser/node/node_name'
require 'prexml/parser/node/node_value'
require 'prexml/parser/node/node_attribute'

module Prexml
  class Parser
    class Node
      
      def initialize(iterator)
        @iterator = iterator
        @node     = Prexml::Node.new
      end

      def parse
        parse_tag
        parse_value_or_childen
        @node
      end

      private

      def parse_tag
        # First closing brace
        @iterator.next

        # Parse the name of the node
        @node.name = NodeName.new(@iterator).parse

        until @iterator.peek == Parser::END_NODE
          @node.attributes.add(NodeAttribute.new(@iterator).parse)
        end
        @iterator.next
      end

      def parse_value_or_childen
        preceding_whitespace = ''
        
        while Parser::WHITESPACE.include?(@iterator.peek)
          preceding_whitespace << @iterator.next
        end

        if @iterator.peek == Parser::START_NODE
          @node.children.add(Parser::Node.new(@iterator).parse)
        else
          @node.value = NodeValue.new(@iterator).parse
        end
      end
    end
  end
end
