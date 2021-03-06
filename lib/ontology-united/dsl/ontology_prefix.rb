module OntologyUnited
  module DSL
    class OntologyPrefix < OntologyEntityBase

      attr_reader :prefix, :iri, :ontology, :subject
      delegate_equality_to method: :identifier

      def initialize(prefix, arg)
        @prefix = prefix
        @iri = arg if arg.is_a?(String)
        @ontology = arg if arg.is_a?(Ontology)
        @subject = arg
      end

      def class(name=nil, as: nil)
        if name.nil?
          super()
        else
          ontology_class = parent.class(name, as: as)
          ontology_class.prefix = self
          ontology_class
        end
      end

      alias_method :ontology_class, :class

      def apply(ontology_class)
        "#{prefix}:#{ontology_class.name}"
      end

      def to_s(serializer: OntologyUnited::Serializer::DEFAULT.new)
        serializer.serialize_prefix(self)
      end

      def identifier
        [@iri || @ontology.name, prefix]
      end

    end
  end
end
