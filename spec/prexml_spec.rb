require 'spec_helper'

describe Prexml do
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

    tree = Prexml.parse_file(file)

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

  it 'can parse an xml string into nodes' do
    xml = """
    <foo one=\"two\">
      <bar three=\"four\">
        Baz
      </bar>
    </foo>
    """

    tree = Prexml.parse(xml)

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
