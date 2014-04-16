module OntologyUnited
  module DSL
    class OntologySentence < OntologyEntityBase

      attr_reader :sentence
      delegate_equality_to method: :sentence

      def initialize(sentence)
        @sentence = sentence
      end

      def to_s(serializer: OntologyUnited::Serializer::DEFAULT.new)
        serializer.serialize_sentence(self)
      end

    end
  end
end
