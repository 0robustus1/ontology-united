module OntologyUnited
  module Serializer
    class SerializerBase
      attr_reader :current_ontology, :current_sentence, :current_symbol

      def initialize(ontology: nil, sentence: nil, symbol: nil)
        @current_ontology = ontology
        @current_sentence = sentence
        @current_symbol = symbol
      end

    end
  end
end
