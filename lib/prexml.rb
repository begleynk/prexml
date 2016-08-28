require "prexml/version"
require "prexml/node"
require "prexml/parser"
require "prexml/document"

module Prexml

  def self.parse_file(file)
    iterator = File.open(file, 'r').each_char
    Prexml::Parser.new(iterator).parse
  end

  def self.parse(string)
    iterator = string.each_char
    Prexml::Parser.new(iterator).parse
  end

  class InvalidNode < RuntimeError
  end
end
