module OntologyUnited::Serializer
  module OWL
    class Manchester < SerializerBase

      def serialize_ontology(ontology)
        ontology.the_prefixes.to_a.join("\n") + "\n" +
          "Ontology: <#{ontology.iri}>\n" +
            ontology.the_imports.to_a.join("\n") + "\n" +
              ontology.the_classes.to_a.join("\n") + "\n" +
                ontology.the_sentences.to_a.join("\n") + "\n"
      end

      def serialize_prefix(ontology_prefix)
        "Prefix: #{ontology_prefix.prefix}: " +
          "<#{ontology_prefix.iri || ontology_prefix.ontology.iri}#>"
      end

      def serialize_import(ontology_import)
        "Import: <#{ontology_import.iri || ontology_import.ontology.iri}>"
      end

      def serialize_class(ontology_class, part_of)
        prefix = ontology_class.prefix
        if prefix
          print_name = prefix.apply(ontology_class)
        else
          "<#{ontology_class.name}>"
        end
        "#{'Class: ' unless part_of}#{print_name}"
      end

      def serialize_sentence(ontology_sentence)
        first_class, middle, second_class = ontology_sentence.sentence
        "#{first_class} #{middle} #{second_class.to_s(part_of: ontology_sentence)}"
      end

    end
  end
end
