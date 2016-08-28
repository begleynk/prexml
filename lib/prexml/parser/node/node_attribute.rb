module Prexml
  class Parser
    class Node
      class NodeAttribute
        def initialize(iterator)
          @iterator = iterator
          @key      = ''
          @value    = ''
        end

        def parse
          # Remove whitespace
          until !Parser::WHITESPACE.include?(@iterator.peek)
            @iterator.next
          end
          parse_key
          parse_value

          { @key => @value }
        end

        private

        def parse_key
          loop do 
            char = @iterator.next 
            if char == Parser::EQUALS
              break
            else
              @key << char
            end
          end
        end

        def parse_value
          # Get the value inside the strings
          string_started = false
          loop do 
            char = @iterator.next 
            if !string_started
              if (Parser::WHITESPACE + Parser::QUOTES).include?(char)
                #skip
              else
                string_started = true
                @value << char
              end
            elsif string_started && Parser::QUOTES.include?(char)
              break
            else
              @value << char
            end
          end
        end
      end
    end
  end
end
