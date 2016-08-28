module Prexml
  class Parser
    class Node
      class NodeValue
        def initialize(iterator)
          @iterator = iterator
          @value    = ''
        end

        def parse
          until @iterator.peek == Parser::START_NODE
            char = @iterator.next
            # TODO: Read about how we should worry about whitespace according
            # to the spec
            unless Parser::WHITESPACE.include?(char)
              @value << char
            end
          end
          @value
        end
      end
    end
  end
end
