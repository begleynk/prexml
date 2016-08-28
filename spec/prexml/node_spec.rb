require 'spec_helper'

describe Prexml::Node do
  
  context 'name' do
    it 'has a name' do
      expect(Prexml::Node.new(name: 'foo').name).to eq 'foo'
    end

    it 'can change the name of the node' do
      node = Prexml::Node.new(name: 'foo')
      node.name = 'bar'
      expect(node.name).to eq 'bar'
    end
  end

  context 'value' do
    it 'can hold a value' do
      expect(Prexml::Node.new(name: 'foo', value: 'bar').value).to eq 'bar'
    end

    it 'cannot hold a value if it has children' do
    end
  end

  context 'attributes' do
    it 'can be given arbitrary attributes' do
      node = Prexml::Node.new(name: 'foo', attributes: { fizz: 'buzz', chuck: 'norriss' })
      expect(node.attributes[:fizz]).to eq 'buzz'
      expect(node.attributes[:chuck]).to eq 'norriss'
    end

    it 'can modify the attributes of the node' do
      node = Prexml::Node.new(name: 'foo', attributes: { fizz: 'buzz' })
      node.attributes[:fizz] = 'hubub'
      expect(node.attributes[:fizz]).to eq 'hubub'
    end

    it 'can be assigned more attributes' do
      node = Prexml::Node.new(name: 'foo')
      node.attributes.add({ 'foo' => 'bar' })
      expect(node.attributes['foo']).to eq 'bar'
    end

    it 'can remove attributes' do
      node = Prexml::Node.new(name: 'foo')
      node.attributes.add({ 'foo' => 'bar' })
      expect(node.attributes['foo']).to eq 'bar'
      node.attributes.remove('foo')
      expect(node.attributes['foo']).to eq nil
    end
  end

  context 'child nodes' do
    it 'cannot have child nodes and a value' do
      expect do
        Prexml::Node.new(name: 'bar', value: 'foo', children: [
          Prexml::Node.new(name: 'asd')
        ])
      end.to raise_error Prexml::InvalidNode, 'Node cannot have child nodes and a value'
    end

    it 'can have child nodes' do
      child  = Prexml::Node.new(name: 'child')
      parent = Prexml::Node.new(name: 'parent', children: [child])

      expect(parent.children.nodes).to eq([child])
    end

    it 'can be given child nodes with <<' do
      parent = Prexml::Node.new(name: 'parent')
      child  = Prexml::Node.new(name: 'child')

      parent.children << child

      expect(parent.children.nodes).to eq([child])
    end

    it 'can check its parent' do
      parent = Prexml::Node.new(name: 'parent')
      child  = Prexml::Node.new(name: 'child')

      parent.children << child

      expect(child.parent).to eq parent
    end

    it 'knows how many children it has' do
      parent = Prexml::Node.new(name: 'parent')
      child1 = Prexml::Node.new(name: 'child1')
      child2 = Prexml::Node.new(name: 'child2')

      parent.children << child1
      parent.children << child2

      expect(parent.children.count).to eq 2
      expect(parent.children.length).to eq 2
    end
  end

  context 'root' do
    it 'node knows if it is the root node' do
      node = Prexml::Node.new(name: 'foo')
      expect(node.root?).to eq true
      expect(node.root).to eq node
    end

    it 'can also be root if the parent is a document' do
      node = Prexml::Node.new(name: 'foo')
      doc  = Prexml::Document.new(nodes: [node])

      expect(node.root?).to eq true
      expect(node.document).to eq doc
      expect(node.parent).to eq doc
    end

    it 'can traverse its parents until it finds the root' do
      parent = Prexml::Node.new(name: 'parent')
      child1 = Prexml::Node.new(name: 'child1')
      child2 = Prexml::Node.new(name: 'child2')

      parent.children << child1
      child1.children << child2

      expect(parent.root?).to eq true
      expect(child1.root?).to eq false
      expect(child2.root?).to eq false

      expect(parent.root).to eq parent
      expect(child1.root).to eq parent
      expect(child2.root).to eq parent
    end
  end

  context 'document' do
    it 'can belong to a document' do
      node  = Prexml::Node.new(name: 'foo')
      child = Prexml::Node.new(name: 'bar')
      doc   = Prexml::Document.new

      node.children.add(child)
      doc.add(node)

      expect(node.document).to eq doc
      expect(child.document).to eq doc
    end

    it 'does not have to belong to a document' do
      node  = Prexml::Node.new(name: 'foo')
      child = Prexml::Node.new(name: 'bar')

      node.children.add(child)

      expect(node.document).to eq nil
      expect(child.document).to eq nil
    end
  end
end
