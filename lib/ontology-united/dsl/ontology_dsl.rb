module OntologyUnited
  module DSL
    class OntologyDSL < BaseDSL

      def self.define(name, as: nil, &block)
        ontology = Ontology.new(name)
        redefine(ontology, as: as, &block)
      end

      def self.redefine(ontology, as: nil, &block)
        stack.push(ontology)
        ontology.as(as) if as
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
