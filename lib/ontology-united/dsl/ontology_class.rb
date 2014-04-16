module OntologyUnited
  module DSL
    class OntologyClass < OntologyEntityBase

      attr_accessor :prefix
      attr_reader :name
      delegate_equality_to method: :name

      def initialize(name)
        @name = name
      end

      def sub_class_of(parent_ontology_class)
        parent.sub_class_of(self, parent_ontology_class)
      end

      def to_s(serializer: OntologyUnited::Serializer::DEFAULT.new, part_of: nil)
        serializer.serialize_class(self, part_of)
      end

    end
  end
end
