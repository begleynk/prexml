require 'prexml/parser/node'

module Prexml
  class Parser

    START_NODE = '<'.freeze
    END_NODE   = '>'.freeze
    WHITESPACE = ["\n", " ", "\t"].freeze
    EQUALS     = '='.freeze
    QUOTES     = ['"', '\''].freeze

    def initialize(file)
      @iterator  = File.open(file, 'r').each_char
      @tree      = Document.new
    end

    def parse
      while char = @iterator.peek
        if char == START_NODE
          @tree.add(Parser::Node.new(@iterator).parse)
        else
          @iterator.next
        end
      end
    rescue StopIteration
      @tree
    end
  end
end
