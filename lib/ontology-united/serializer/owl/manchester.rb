module OntologyUnited::Serializer
  module OWL
    class Manchester < SerializerBase

      def serialize_ontology(ontology)
        to_s = Proc.new { |obj| obj.to_s(serializer: self) }
        process ontology do
          str = ''
          str << join(ontology.the_prefixes, "\n", &to_s)
          str << "\n" unless ontology.the_prefixes.empty?
          str << "Ontology: <#{ontology.iri}>\n"
          str << join(ontology.the_imports, "\n", &to_s)
          str << "\n" unless ontology.the_imports.empty?
          str << join(ontology.the_classes, "\n", &to_s)
          str << "\n" unless ontology.the_classes.empty?
          str << join(ontology.the_sentences, "\n", &to_s)
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
            "<#{ontology_class.name}>"
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
        parent_current.nil? ||
          # or the parent is an ontology itself
          ontology?(parent_current) ||
          # or it is the first symbol of a sentence
          sentence?(parent_current) && parent_current.sentence.first == ontology_class
      end

    end
  end
end
