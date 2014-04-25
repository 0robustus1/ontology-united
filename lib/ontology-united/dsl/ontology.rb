require 'tempfile'
require 'set'

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

      def elements
        the_prefixes + the_imports + the_classes + the_sentences
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

      def redefine(ontology = self, &block)
        OntologyDSL.redefine(ontology, &block)
      end

      def imports(arg, &block)
        if block && arg.is_a?(Ontology)
          ontology = arg
          arg = redefine(&block)
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

      def to_s(serializer: OntologyUnited::Serializer::DEFAULT.new)
        serializer.serialize_ontology(self)
      end

      def file
        create_tempfile if @file.nil?
        @file
      end

      def create_tempfile
        filename = name.match(%r(([^/]+)\.\w+$))[1]
        file = Tempfile.new([filename, '.owl'])
        @iri = "file://#{file.path}"
        @file = file
        file.write(self.to_s)
        file.flush
        file.rewind
        file
      end

    end
  end
end
