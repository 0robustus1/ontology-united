module OntologyUnited
  module DSL
    class OntologyClass < OntologyEntityBase

      delegate_equality_to method: :identifier

      attr_accessor :prefix
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def sub_class_of(parent_ontology_class, as: nil)
        sentence = parent.sub_class_of(self, parent_ontology_class)
        sentence.as(as) if as
        sentence
      end

      def to_s(serializer: OntologyUnited::Serializer::DEFAULT.new)
        serializer.serialize_class(self)
      end

      def identifier
        prefix ? prefix.identifier + [name] : [name]
      end

    end
  end
end
