module OntologyUnited
  module DSL
    class OntologySentence < OntologyEntityBase

      attr_reader :sentence
      delegate_equality_to method: :sentence

      def initialize(sentence)
        @sentence = sentence
      end

      def to_s
        first_class, middle, second_class = sentence
        "#{first_class} #{middle} #{second_class.to_s(part_of: self)}"
      end

    end
  end
end
