module Prexml
  class Parser
    class Node
      class NodeName
        def initialize(iterator)
          @iterator = iterator
          @name     = ''
        end

        def parse
          # Make sure we don't have whitespace before the name
          until !Parser::WHITESPACE.include?(@iterator.peek)
            @iterator.next
          end

          # Now get the name
          until Parser::WHITESPACE.include?(@iterator.peek)
            @name << @iterator.next
          end
          @name
        end
      end
    end
  end
end
