module OntologyUnited
  module DSL
    class OntologyImport < OntologyEntityBase

      attr_reader :iri, :ontology, :subject
      delegate_equality_to method: :subject

      def initialize(arg)
        @iri = arg if arg.is_a?(String)
        @ontology = arg if arg.is_a?(Ontology)
        @subject = arg
      end

      def to_s(serializer: OntologyUnited::Serializer::DEFAULT.new)
        serializer.serialize_import(self)
      end

    end
  end
end
