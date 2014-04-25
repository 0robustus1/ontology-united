module OntologyUnited::Serializer
  module OWL
    class Manchester < SerializerBase

      def serialize_ontology(ontology)
        process ontology do
          str = "Ontology: <#{ontology.iri}>\n"
          str << join(ontology.elements, "\n") do |element|
            element.to_s(serializer: self)
          end
        end
      end

      def serialize_prefix(ontology_prefix)
        process ontology_prefix do
          "Prefix: #{ontology_prefix.prefix}: " <<
            "<#{ontology_prefix.iri || ontology_prefix.ontology.iri}#>"
        end
      end

      def serialize_import(ontology_import)
        process ontology_import do
          "Import: <#{ontology_import.iri || ontology_import.ontology.iri}>"
        end
      end

      def serialize_class(ontology_class)
        process ontology_class do
          prefix = ontology_class.prefix
          if prefix
            print_name = prefix.apply(ontology_class)
          else
            print_name = "<#{ontology_class.name}>"
          end
          "#{'Class: ' if class_definition?(ontology_class)}#{print_name}"
        end
      end

      def serialize_sentence(ontology_sentence)
        opts = {serializer: self}
        process ontology_sentence do
          first_class, middle, second_class = ontology_sentence.sentence
          "#{first_class.to_s(opts)} #{middle} #{second_class.to_s(opts)}"
        end
      end

      def class_definition?(ontology_class)
        # if no parent is set
        parent.nil? ||
          # or the parent is an ontology itself
          ontology?(parent) ||
          # or it is the first symbol of a sentence
          sentence?(parent) && parent.sentence.first == ontology_class
      end

    end
  end
end
