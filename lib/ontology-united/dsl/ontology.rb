require 'tempfile'

module OntologyUnited
  module DSL
    class Ontology < BaseDSL

      attr_reader_with_default :the_classes, :the_imports,
        :the_sentences, :the_prefixes, default: Set
      attr_reader :name

      def initialize(name)
        establish_defaults
        @name = name
      end

      def iri
        create_tempfile if @iri.nil?
        @iri
      end

      def class(name=nil)
        if name.nil?
          super()
        else
          ontology_class = OntologyClass.new(name)
          the_classes << ontology_class
          ontology_class
        end
      end

      alias_method :ontology_class, :class

      def define(*args, &block)
        OntologyDSL.define(*args, &block)
      end

      def imports(arg, &block)
        if block || arg.is_a?(Ontology)
          ontology = arg
          arg = define(ontology.name, &block)
        end
        the_import = OntologyImport.new(arg)
        the_imports << the_import
        the_import
      end

      def prefix(prefix, iri=self)
        the_prefix = OntologyPrefix.new(prefix, iri)
        the_prefixes << the_prefix
        the_prefix
      end

      def sub_class_of(child_ontology_class, parent_ontology_class)
        sentence = OntologySentence.new([
          child_ontology_class,
          'SubClassOf:',
          parent_ontology_class
        ])
        parent_ontology_class.part_of(sentence)
        the_sentences << sentence
        sentence
      end

      def to_s
        the_prefixes.to_a.join("\n") + "\n" +
          "Ontology: <#{iri}>\n" +
            the_imports.to_a.join("\n") + "\n" +
              the_classes.to_a.join("\n") + "\n" +
                the_sentences.to_a.join("\n") + "\n"
      end

      def file
        @file ||= create_tempfile
      end

      def create_tempfile
        filename = name.match(%r(([^/]+)\.\w+$))[1]
        file = Tempfile.new([filename, '.owl'])
        @iri = "file://#{file.path}"
        file.write(self.to_s)
        file.rewind
        file
      end

    end
  end
end
