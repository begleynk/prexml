require 'spec_helper'

describe Prexml::Parser do
  it 'can parse an XML file into nodes' do
    file = Tempfile.new('example_spec')
    file << """
    <foo one=\"two\">
      <bar three=\"four\">
        Baz
      </bar>
    </foo>
    """
    file.rewind

    tree = Prexml::Parser.new(file).parse

    expected = Prexml::Document.new(nodes: [
      Prexml::Node.new(name: 'foo', 
                       attributes: { "one" => "two" }, 
                       children: [
        Prexml::Node.new(name: 'bar', 
                         attributes: { "three" => "four" }, 
                         value: 'Baz')
      ])
    ])

    expect(tree).to be == expected
  end
end
