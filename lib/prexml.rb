require "prexml/version"
require "prexml/node"
require "prexml/parser"
require "prexml/document"

module Prexml

  def self.parse_file(file)
    Prexml::Parser.new(file).parse
  end

  class InvalidNode < RuntimeError
  end
end
