module OntologyUnited
  module Serializer
    class SerializerBase
      include Stack

      def initialize(current: nil)
        stack.push(current) if current
      end

      def process(subject, &block)
        mark!(subject)
        result = block.call
        unmark!
        result
      end

      def mark!(subject)
        stack.push(subject)
      end

      def unmark!
        stack.pop
      end

      def join(elements, sep)
        elements.reduce('') do |str, raw_element|
          str << sep unless str.empty?
          element = yield raw_element
          str << element
        end
      end

      def ontology?(subject)
        subject.is_a?(OntologyUnited::DSL::Ontology)
      end

      def class?(subject)
        subject.is_a?(OntologyUnited::DSL::OntologyClass)
      end

      def sentence?(subject)
        subject.is_a?(OntologyUnited::DSL::OntologySentence)
      end

    end
  end
end
