
module Prexml
  class Node
    class AttributeList

      def initialize(parent, attributes_hash)
        @attributes_hash = attributes_hash
        @parent_node     = parent
      end

      def [](key)
        @attributes_hash[key]
      end

      def []=(key, value)
        @attributes_hash[key] = value
      end

      def add(key_value)
        key_value.each do |key, value|
          @attributes_hash[key] = value
        end
      end

      def remove(key)
        delete(key)
      end

      def delete(key)
        @attributes_hash.delete(key)
      end

      def inspect
        @attributes_hash.inspect
      end

      def to_h
        @attributes_hash
      end

      def ==(other_attributes)
        @attributes_hash == other_attributes.to_h
      end
    end
  end
end
