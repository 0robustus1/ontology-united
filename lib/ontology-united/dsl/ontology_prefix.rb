module OntologyUnited
  module DSL
    class OntologyPrefix < OntologyEntityBase

      attr_reader :prefix, :iri, :ontology, :subject
      delegate_equality_to method: :prefix

      def initialize(prefix, arg)
        @prefix = prefix
        @iri = arg if arg.is_a?(String)
        @ontology = arg if arg.is_a?(Ontology)
        @subject = arg
      end

      def class(name=nil)
        if name.nil?
          super()
        else
          ontology_class = parent.class(name)
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

    end
  end
end
