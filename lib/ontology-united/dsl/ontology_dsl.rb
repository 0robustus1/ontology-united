module OntologyUnited
  module DSL
    class OntologyDSL < BaseDSL

      def self.define(name, &block)
        ontology = Ontology.new(name)
        redefine(ontology, &block)
      end

      def self.redefine(ontology, &block)
        stack.push(ontology)
        if block
          if block.arity == 1
            block.call(ontology)
          else
            ontology.instance_eval(&block)
          end
        end
        stack.pop
        ontology
      end

    end
  end
end
