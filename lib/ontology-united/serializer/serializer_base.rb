module OntologyUnited
  module Serializer
    class SerializerBase
      attr_accessor :current, :parent_current

      def initialize(current: nil)
        self.current = current
        self.parent_current = nil
      end

      def process(subject, &block)
        previous_parent = mark!(subject)
        result = block.call
        mark!(parent_current, previous_parent)
        result
      end

      def mark!(subject, parent=nil)
        previous_parent = parent_current
        parent_current = parent || current
        current = subject
        previous_parent
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
